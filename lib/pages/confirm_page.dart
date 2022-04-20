import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';

class ConfirmPage extends StatelessWidget {
  static const id = 'confirm_page';
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft,child: BackButton()),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Something goes here', style: kSubTitleStyle,),
                        SizedBox(height: 50),
                        TextButton(onPressed: () {
                          Navigator.pushNamed(context, 'navigation_page');
                        }, style: kRedButtonStyle ,child: Text('Begin Navigation', style: kTitleStyle.copyWith(color: Colors.white),))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
