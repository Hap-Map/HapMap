import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/pages/search_page.dart';

class TutorialPage2 extends StatefulWidget {
  static const id = 'tutorial_page2';

  const TutorialPage2({Key? key}) : super(key: key);

  @override
  State<TutorialPage2> createState() => _TutorialPage2State();
}

class _TutorialPage2State extends State<TutorialPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Instructions",
                            style: kTitleStyle,
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Once you start navigation, listen to the app for your next turn direction.',
                          style: kBodyStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'There is a large button with a touch icon below the End Tutorial button - hold your finger on it to feel the distance between you and the intersection.',
                            style: kBodyStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'If you feel lost, shake your device anytime to get your current location, as well as the next direction.',
                            style: kBodyStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Feel free to click on the reroute button anytime during navigation for a new set of directions.',
                            style: kBodyStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Padding(
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
                  onPressed: () {},
                  style: kBlueButtonStyle,
                  key: const Key('Reroute')
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Text(
                    'End Tutorial',
                    style: kTitleStyle,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SearchPage.id);
                  },
                  style: kRedButtonStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {},
                  child: Icon(
                      Icons.touch_app_rounded,
                      color: Colors.white,
                      size: 100,
                      semanticLabel: 'Keep finger on the screen for haptic feedback'
                  ),
                  style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: kHapticTouchIconColor),
                  key: const Key('HapticButton'))
              ),
            ],
          ),
        )
    );
  }
}
