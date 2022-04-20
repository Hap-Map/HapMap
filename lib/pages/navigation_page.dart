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
    return PageBackground(
        child: Column(
      children: [
        Expanded(

          child: Align(
            alignment: Alignment.bottomCenter,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: TextButton(
                child: Text('End Navigation', style: kTitleStyle,),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('search_page'));
                },
                style: kRedButtonStyle,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
