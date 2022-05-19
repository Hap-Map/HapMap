# HapMap
<img src="https://github.com/Hap-Map/HapMap/blob/main/images/hapmap_logo.png?raw=true" alt="hapmap_logo" width="200"/>
HapMap is a sensory navigation application that makes independent travel more accessible for low-vision individuals. It utilizes a combination of auditory, haptic, and vibration cues to inform users of their route. For example: as the user approaches a turn, the frequency of the haptic feedback increases to indicate their proximity to the turn. This reduces the uncertainty that comes with standard navigation systems that may abruptly give instructions.

## Repo Layout
**HapMap/lib**: Files to run, edit, and integrating Google Map API to the flutter app
- **HapMap/lib/API/** Files related to Google Maps API endpoint and returned data structures
- **HapMap/lib/pages** Layouts and functionality for front-end UI
- **HapMap/lib/constants.dart** global constants
- **HapMap/lib/main.dart** Application entry point

**HapMap/reports**: Weekly reports and meeting agenda

## Set Up Environment
There are a few installations that are needed in order to build, run, and test HapMap.
- [Install Flutter](https://docs.flutter.dev/get-started/install)
- [Download & Install Android Studio](https://developer.android.com/studio/install)
- [Create a Virtual Device](https://developer.android.com/studio/run/managing-avds#system-image) (Android devices are recommended)
  - If using an iOS Simulator, note that [CocoaPods](https://cocoapods.org) is required and that it cannot simulate a route/travel

## How to Build
1. Clone the repository
2. Add one API key for Google Places and Directions to a dart file in `lib/api/.key` such that `const MAPS_API_KEY="API KEY"`. Make sure the file is imported into directions_api.dart and place_api.dart and that the import statement for `api/maps.dart` is removed! We have included an empty `actions.dart` file for you to put the key in, or you may create your own. Also be sure to include the API key in `ios/Runner/AppDelegate.swift` and `android/app/src/main/AndroidManifest.xml`.
3. Open an iOS or Android emulator or [connect a physical device](https://developer.android.com/studio/run/device) in Android Studio
4. In the command line, navigate to the HapMap directory and run `bash clean_and_run.sh` to build the app

## How to Test
### Simulating a Route
For tips on how to use an Android emulatior, please see the [official Android documentation](https://developer.android.com/studio/run/emulator)

### Automated Tests
1. See the "How to Build" section for instructions to set up the project locally
2. In the top-level directory, run `flutter test` to run all test files in the /test folder

To add tests, create a new file in the test folder in the format \<what_is_being_tested\>_test.dart

For help with testing, view the [Dart Testing Documentation](https://dart.dev/guides/testing)


## Related Files
[Figma Wireframe](https://www.figma.com/file/aBOhJMR48TNw95Jmrq3YMl/HapMap?node-id=0%3A1) \
[Spec and Requirements](https://docs.google.com/document/d/1I34HH7h0vPHHwxrdcsIazLe2c-b-zCE0JoaApBoYGJw/edit?usp=sharing) \
[Trello Board](https://trello.com/invite/b/SqZ7BMdB/1bc12234fd4251b4506332ddbf8a9e25/hapmap-tasks)

## Authors and Acknowledgements
This project was developed as part of the UW CSE 403: Software Engineering course by Emily Chang, Simona Liao, Jesse Hu, Lauren Cavanaugh, Pulkit Malhotra, and Aditya Nayak. Special thanks to Professor René Just and TA Hannah K. Potter for their support and guidance on this project!
