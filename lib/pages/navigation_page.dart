import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:hap_map/api/shake_api.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/models/directions_model.dart';
import 'package:html/parser.dart';

import '../api/location_api.dart';
import '../api/place_api.dart';
import '../models/place_model.dart';

class NavigationPage extends StatefulWidget {
  static const id = 'navigation_page';

  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

double METERS_TO_UPDATE_PLACE = 100;
double METERS_TO_UPDATE_INSTRUCTION = 5;
double METERS_EPSILON = 2;

class _NavigationPageState extends State<NavigationPage> {
  Position? _lastPosUpdated;
  Position? _currentPosition;
  Place? _current;
  Place? _destination;
  Directions? _directions;
  DirectionsIterator? _iter;
  String? _displayInstruction;
  late double _distToEnd;
  bool _destinationReached = false; // if final destination has been reached
  bool _instrSkipped = false;       // if an instruction is skipped, we dont want to skip more than one (otherwise assume user is lost)
  bool _userLost = false;           // if after skipping an instruction and user is still not making progress towards end point
                                    // we assume user is lost and stop iterating over directions (and displaying new ones to user)
  final FlutterTts tts = FlutterTts();

  get endNavigationButton => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextButton(
          child: const Text(
            'End Navigation',
            style: kTitleStyle,
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('search_page'));
            SemanticsService.announce("Ending navigation", TextDirection.ltr);
          },
          style: kRedButtonStyle,
          key: const Key('EndNavigation')
        ),
  );

  get rerouteButton =>Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.directions, size: 32,),
            SizedBox(width: 8,),
            const Text(
              'Reroute',
              style: kTitleStyle,
            ),
          ],
        ),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('confirm_page'));
          SemanticsService.announce("Rerouting", TextDirection.ltr);
        },
        style: kBlueButtonStyle,
        key: const Key('Reroute')
    ),
  );

  get hapticButton => ConstrainedBox(
    constraints: BoxConstraints.loose(Size(100, 100)),
    child: TextButton(
        onPressed: () {},
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(
              Icons.touch_app_rounded,
              size: 100,
              color: Colors.white,
              semanticLabel: 'Keep finger on the screen for haptic feedback'
          ),
        ),
        style: TextButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: kHapticTouchIconColor),
        key: const Key('HapticButton')),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationApi.addOnLocationUpdateListener(onLocationUpdated);
    ShakeApi.startOnShakeUpdates();
    ShakeApi.addOnShakeListener(onShake);
    tts.speak("Starting route");
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      List _arguments = ModalRoute.of(context)!.settings.arguments as List;
      _currentPosition = _arguments[0];
      _lastPosUpdated = _currentPosition;
      _current = _arguments[1];
      _destination = _arguments[2];
      _directions = _arguments[3];
      _iter = DirectionsIterator(_directions!);
      _displayInstruction = _iter!.getCurrentInstruction();
      _distToEnd = distanceLatLng(_iter!.getStepEnd()!, _currentPosition!);
    }

    return Scaffold(
        body: PageBackground(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              shadowColor: Colors.blueGrey,
              child: MergeSemantics(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(distToDisplay(), style: kSubTitleStyle.copyWith(fontWeight: FontWeight.bold),),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Html(
                              data: _destinationReached
                                  ? '<html><body></b>Destination Reached</b></body></html>'
                                  : _displayInstruction,
                              style: {
                                "body": Style(
                                    fontSize: FontSize(25),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    textAlign: TextAlign.center)
                              }),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                  _destination != null
                                      ? "To: " + _destination!.name
                                      : "Loading Destination...",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                    _current != null
                                        ? "Current Location: " + _current!.name
                                        : "Finding Current Location...",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    textAlign: TextAlign.center)),
                          ),
                        ],
                      ),
                    ),
                    rerouteButton,
                  ],
                ),
              ),

            ),
            endNavigationButton,
            hapticButton
          ],
        ),
      ],
    )));
  }

  @override
  void dispose() {
    super.dispose();
    LocationApi.removeOnLocationUpdateListener(onLocationUpdated);
    ShakeApi.stopOnShakeUpdates();
  }

  onShake() {
    // TODO: Show dialog that pops up when user shakes phone.
  }

  onLocationUpdated(Position pos) {
    setState(() {
      Position prevPosition = _currentPosition!;
      _currentPosition = pos;
      double prevDistance = _distToEnd;
      _distToEnd = distanceLatLng(_iter!.getStepEnd()!, _currentPosition!);

      if (isCloseEnough(_iter!.getStepEnd(), _currentPosition!)) {
        // User is close enough to the endpoint so as long as user isnt presumed lost
        // or this isn't the last instruction (destination reached)
        // we iterate to the next instruction
        if (!_iter!.hasNext()) {
          _destinationReached = true;
          tts.speak("Destination Reached");
        } else if (!_userLost) {
          _iter!.moveNext();
          _distToEnd = distanceLatLng(_iter!.getStepEnd()!, _currentPosition!);
        }
      } else {
        if (prevDistance <= max(_distToEnd - METERS_EPSILON, 0)) {
          // user has either passed instruction end so we see if we should move to the next instruction
          // or the user is lost
          if (!_iter!.hasNext()) {
            _destinationReached = true;
            tts.speak("Destination Reached");
          } else if (_instrSkipped) {
            _userLost = true;
          } else {
            double nextPrevDistance = distanceLatLng(_iter!.getNextEnd()!, prevPosition);
            double nextCurDistance =  distanceLatLng(_iter!.getNextEnd()!, _currentPosition!);

            if (nextPrevDistance > nextCurDistance) {
              // User is moving towards the next end point so we skip instruction by default and assume user is on track
              _iter!.moveNext();
              _displayInstruction = _iter!.getCurrentInstruction();
              _distToEnd = nextCurDistance;
              _instrSkipped = true;
            } else {
              _instrSkipped = true;
              _userLost = false;
            }
          }
        } else {
          _instrSkipped = false;
        }
      }
    });

    if (isPastStart(_iter!.getStepStart(), _currentPosition!)) {
      // When user gets a certain distance away from the step start, display instruction is updated
      // to next instruction so user knows what to do when they reach the end of this step
      if (!_destinationReached && _displayInstruction != _iter!.getNextInstruction()) {
        setState(() {
          _displayInstruction = _iter!.getNextInstruction();
          final document = parse(_displayInstruction!);
          final parsedString = parse(document.body?.text).documentElement?.text;
          tts.speak(parsedString!);
        });
      }
    }

    if (isFarEnough(_lastPosUpdated!, pos)) {
      updatePlace(pos);
    }
  }

  bool isFarEnough(Position p1, Position p2) {
    return distance(p1, p2) > METERS_TO_UPDATE_PLACE;
  }

  double distance(Position p1, Position p2) {
    return Geolocator.distanceBetween(
        p1.latitude, p1.longitude, p2.latitude, p2.longitude);
  }

  double distanceLatLng(LatLng p1, Position p2) {
    var dist = Geolocator.distanceBetween(
        p1.latitude, p1.longitude, p2.latitude, p2.longitude);
    return dist;
  }

  bool isCloseEnough(LatLng? p1, Position p2) {
    return distanceLatLng(p1!, p2) < METERS_EPSILON;
  }

  void updatePlace(Position pos) {
    PlaceApi.getPlace(pos).then((place) => setState(() {
          _currentPosition = pos;
          _lastPosUpdated = _currentPosition;
          _current = place;
        }));
  }

  bool isPastStart(LatLng? p1, Position p2) {
    return distanceLatLng(p1!, p2) > min(METERS_TO_UPDATE_INSTRUCTION, (_iter!.curStepSize / 2));
  }

  bool makingProgress(Position previous, Position current) {
    var prevDist = distanceLatLng(_iter!.getStepEnd()!, previous);
    var curDist = distanceLatLng(_iter!.getStepEnd()!, current);

    return prevDist >= curDist - METERS_EPSILON;
  }

  String distToDisplay() {
    if (_distToEnd > 1000) {
      return 'In ' + (_distToEnd / 1000).toStringAsPrecision(2) + ' km';
    } else {
      return 'In ' + _distToEnd.round().toString() + ' m';
    }
  }
}
