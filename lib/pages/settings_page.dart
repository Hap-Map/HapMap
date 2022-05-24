import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';

class SettingsPage extends StatefulWidget {
  static const id = 'settings_page';

  static const shortcuts = [
    'Just Dictation',
    'Shake Phone',
    'Triple Tap Screen'
  ];
  static String dropDownValue = shortcuts.first;
  static bool isSwitchedHaptic = true;
  static bool isSwitchedVibration = false;
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            child: BackButton(),
            alignment: Alignment.topLeft,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Settings',
                        textAlign: TextAlign.center,
                        style: kTitleStyle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Location Shortcut',
                            textAlign: TextAlign.center,
                            style: kBodyStyle,
                            softWrap: true,
                          ),
                        ),
                        DropdownButton<String>(
                          value: SettingsPage.dropDownValue,
                          items: SettingsPage.shortcuts.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: kBodyStyle),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // TODO: CHANGE SETTINGS
                            print(newValue);
                            setState(() {
                              SettingsPage.dropDownValue = newValue!;
                            });
                          },
                        ),
                        // Column(
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.greenAccent, width: 2.0),
                        //           borderRadius: const BorderRadius.all(Radius.circular(5))
                        //       ),
                        //       child: const Text(
                        //         'Shake Phone',
                        //         textAlign: TextAlign.center,
                        //         style: kBodyStyle,
                        //       ),
                        //     ),
                        //     const Text(
                        //       'Triple-Tap Screen',
                        //       textAlign: TextAlign.center,
                        //       style: kBodyStyle,
                        //     ),
                        //     const Text(
                        //       'Only Dictation',
                        //       textAlign: TextAlign.center,
                        //       style: kBodyStyle,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Haptic Feedback',
                          textAlign: TextAlign.center,
                          style: kBodyStyle,
                        ),
                        Switch(
                          value:  SettingsPage.isSwitchedHaptic,
                          onChanged: (value) {
                            setState(() {
                              SettingsPage.isSwitchedHaptic = value;
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vibration',
                          textAlign: TextAlign.center,
                          style: kBodyStyle,
                        ),
                        Switch(
                          value:  SettingsPage.isSwitchedVibration,
                          onChanged: (value) {
                            setState(() {
                              SettingsPage.isSwitchedVibration = value;
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(6.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.greenAccent[700],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Replay Tutorial',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      SettingsPage.dropDownValue = SettingsPage.shortcuts.first;
                      SettingsPage.isSwitchedHaptic = true;
                      SettingsPage.isSwitchedVibration = false;
                    });
                  },
                  style: kRedButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Reset to Default',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
