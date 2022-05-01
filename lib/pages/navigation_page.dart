import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';

class NavigationPage extends StatefulWidget {
  static const id = 'navigation_page';
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageBackground(
        child: Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              child: const Text('End Navigation', style: kTitleStyle,),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('search_page'));
              },
              style: kRedButtonStyle,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 300.0,
          width: 360.0,
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xfff7f9f7),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 4),
                    ),
                  ],
              ),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("To: Mary Gates Hall",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.left),
                  Text("NOW: Prepare to turn right onto NE 45th St",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                      textAlign: TextAlign.left),
                  Text("Current Location: 8th Ave NE",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                      textAlign: TextAlign.left),
                ],
              ),
            )
          ),
          IconButton(
            icon: Image.asset('images/hapticTouchButton.png'),
            iconSize: 250,
            onPressed: () {},
            alignment: Alignment.bottomCenter,
          )
        ],
      ))
    );
  }
}
