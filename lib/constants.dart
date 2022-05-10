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

final kHapticTouchIconColor = Colors.indigo.shade600;

const lightGreen = Color(0xFFB7EEBC);
const teal = Color(0xCC59B5AF);
const kBackgroundGradientColor = <Color>[teal, lightGreen];

const kTitleStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

const kSubTitleStyle = TextStyle(
  fontSize: 20,
);

final kButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: Colors.white,
    primary: Colors.black);

final kRedButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: Colors.redAccent[700],
    primary: Colors.white);

final kBlueButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: Colors.blueAccent,
    primary: Colors.white);

final kInputBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);
