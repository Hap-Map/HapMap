import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          child: SingleChildScrollView(
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
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "How to Use HapMap:",
                              style: kTitleStyle,
                            ),
                          ),
                          Column(
                            children: [for(var i in _instructions)
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(i,
                                  style: kBodyStyle,),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){},
                  style: kBlueButtonStyle,
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Start Tutorial',
                          style: kTitleStyle)),
                ),
                 Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () => launchUrlString('https://github.com/Hap-Map/HapMap/issues'),
                      child: const Text("Having an issue with Hapmap? Tap here",
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  ),
              ],
            ),
          )),
    );
  }
}