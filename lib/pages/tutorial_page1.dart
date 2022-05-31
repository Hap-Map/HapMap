import 'package:flutter/material.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/pages/tutorial_page2.dart';

class TutorialPage1 extends StatefulWidget {
  static const id = 'tutorial_page1';

  const TutorialPage1({Key? key}) : super(key: key);

  @override
  State<TutorialPage1> createState() => _TutorialPage1State();
}

class _TutorialPage1State extends State<TutorialPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageBackground(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Welcome to HapMap!",
                              style: kTitleStyle,
                            ),
                          ),
                          Text(
                            'A free app that helps you navigate your neighborhood with just a few shakes, words, or clicks. ',
                            style: kBodyStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'How it Works:',
                              style: kSubTitleStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '1. Search for a location using the search bar',
                              style: kBodyStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '2. Start Navigation',
                              style: kBodyStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '3. Listen to the app for the next directions',
                              style: kBodyStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                            '4. Touch the screen (haptic touch) to detect when to make a turn',
                            style: kBodyStyle,
                            textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, TutorialPage2.id);
                  },
                  style: kBlueButtonStyle,
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Next Page',
                          style: kTitleStyle)),
                ),
              ),
              ],
            ),
          ),
        )
    );
  }
}
