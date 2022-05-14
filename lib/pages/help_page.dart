import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';

class HelpPage extends StatelessWidget {
  static const id = 'help_page';
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: PageBackground(
          child: Column(
            children: [
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              Text("Help",
              style: kTitleStyle.copyWith(fontSize: 32.0),
              ),
              SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "How to Use HapMap:",
                    style: kTitleStyle,
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextButton(
                onPressed: (){},
                style: kBlueButtonStyle,
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Start Tutorial',
                        style: kTitleStyle)),
              )
            ],
          )),
    );
  }
}