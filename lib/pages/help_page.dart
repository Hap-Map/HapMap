import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';

class HelpPage extends StatefulWidget {
  static const id = 'help_page';

  const HelpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HelpPage();
}

class _HelpPage extends State<HelpPage> {
  List<String> _instructions = [];

  Future<List<String>> _loadInstructions() async {
    List<String> instructions = [];
    await DefaultAssetBundle.of(context)
        .loadString('assets/how-to-use.txt').then((i) {
      for (String dir in const LineSplitter().convert(i)) {
        instructions.add(dir);
      }
    });
    return instructions;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> instructions = await _loadInstructions();

    // Notify the UI and display the questions
    setState(() {
      _instructions = instructions;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
          child: Column(
            children: [
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              Padding(
                  padding: EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        const Text(
                          "How to Use HapMap:",
                          style: kTitleStyle,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child:  Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [for(var i in _instructions)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(i,
                                    style: kBodyStyle,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: (){},
                style: kBlueButtonStyle,
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Start Tutorial',
                        style: kTitleStyle)),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text("For any issues with this app, "
                    "submit your feedback on our official "
                    "Github Repository's issues tab: "
                    "https://github.com/Hap-Map/HapMap/issues",
                  textAlign: TextAlign.center,),
              ),
            ],
          )),
    );
  }
}