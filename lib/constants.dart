import 'package:flutter/material.dart';

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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    backgroundColor: Colors.black,
    primary: Colors.white
);