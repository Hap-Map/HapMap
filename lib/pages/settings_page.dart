import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/pages/search_page.dart';

class SettingsPage extends StatefulWidget {
  static const id = 'settings_page';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double elementHeightSpacing = deviceHeight * 0.05;
    double innerElementHeightSpacing = deviceHeight * 0.03;
    double locationChoicesHeightSpacing = deviceHeight * 0.02;
    double rowBoundsSpacing = deviceWidth * 0.08;
    double buttonSpacing = deviceWidth * 0.5;
    bool isSwitchedHaptic = true;
    bool isSwitchedVibration = false;
    return Scaffold(
      body: PageBackground(
          child: Column(
        children: [
          SizedBox(height: elementHeightSpacing),
          Container(
          height: deviceHeight * 0.55,
          width: deviceWidth * 0.8,
          decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          child: Column(
          children: [
            SizedBox(height: innerElementHeightSpacing),
            IntrinsicHeight(
               child: Stack(
               children: const [
                 Align(
                   child: BackButton(),
                   alignment: Alignment.topLeft,
                 ),
                 Positioned(
                   child: Center(
                         child: Text(
                           'Settings',
                           textAlign: TextAlign.center,
                           style: kTitleStyle,
                         ),
                   )
                 ),
               ],
               ),
            ),
            SizedBox(height: innerElementHeightSpacing),
            Row(
              children: [
                SizedBox(width: rowBoundsSpacing),
                const Text(
                  'Get Location',
                  textAlign: TextAlign.center,
                  style: kBodyStyle,
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.greenAccent, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      child: const Text(
                        'Shake Phone',
                        textAlign: TextAlign.center,
                        style: kBodyStyle,
                      ),
                    ),
                    SizedBox(height: locationChoicesHeightSpacing),
                    const Text(
                      'Triple-Tap Screen',
                      textAlign: TextAlign.center,
                      style: kBodyStyle,
                    ),
                    SizedBox(height: locationChoicesHeightSpacing),
                    const Text(
                      'Only Dictation',
                      textAlign: TextAlign.center,
                      style: kBodyStyle,
                    ),
                  ],
                ),
                SizedBox(width: rowBoundsSpacing),
              ],
            ),
            SizedBox(height: elementHeightSpacing),
            Row(
              children: [
                SizedBox(width: rowBoundsSpacing),
                const Text(
                  'Haptic Feedback',
                  textAlign: TextAlign.center,
                  style: kBodyStyle,
                ),
                Spacer(),
                Switch(
                  value: isSwitchedHaptic,
                  onChanged: (value) {
                    setState(() {
                      isSwitchedHaptic = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                SizedBox(width: rowBoundsSpacing),
              ],
            ),
            SizedBox(height: innerElementHeightSpacing),
            Row(
              children: [
                SizedBox(width: rowBoundsSpacing),
                const Text(
                  'Vibration',
                  textAlign: TextAlign.center,
                  style: kBodyStyle,
                ),
                Spacer(),
                Switch(
                  value: isSwitchedVibration,
                  onChanged: (value) {
                    setState(() {
                      isSwitchedVibration = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                SizedBox(width: rowBoundsSpacing),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(6.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.greenAccent[700],
              ),
              child: const Text(
                'Replay Tutorial',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
            )
          ],
          ),
          ),
          SizedBox(height: elementHeightSpacing),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                  SizedBox(
                    height: deviceHeight * 0.07,
                    width: buttonSpacing,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: kRedButtonStyle,
                      child: const Text(
                        'Reset to Default',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: innerElementHeightSpacing),
                SizedBox(
                    height: deviceHeight * 0.07,
                    width: buttonSpacing,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: kGreenButtonStyle,
                      child: const Text(
                        'Save and Return',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ),
                ),
              ],
            )
          )
        ],
        ),
      )
    );
  }
}
