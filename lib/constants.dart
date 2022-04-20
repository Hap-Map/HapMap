import 'package:flutter/material.dart';

Widget PageBackground({required Widget child}) {
    return Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: kBackgroundGradientColor,
    ),
    ),
    child: SafeArea(child: child));
}
const kPrimaryColor = Colors.black;
const kSecondaryColor = Colors.white;

const kBackgroundGradientColor = <Color>[Colors.teal, Colors.indigoAccent];

const kTitleStyle = TextStyle(
fontSize: 25,
fontWeight: FontWeight.bold
);

const kSubTitleStyle = TextStyle(
    fontSize: 20,

);

final kButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    backgroundColor: Colors.black,
    primary: Colors.white
);

final kRedButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
    ),
    backgroundColor: Colors.redAccent[700],
    primary: Colors.white
);