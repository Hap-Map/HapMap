import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';

class SettingsPage extends StatefulWidget {
  static const id = 'settings_page';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
          child: Column(
        children: [
          Align(
            child: BackButton(),
            alignment: Alignment.topLeft,
          ),
          Expanded(child: Container())
        ],
      )),
    );
  }
}
