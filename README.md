# HapMap
<img src="https://github.com/Hap-Map/HapMap/blob/main/images/hapmap_logo.png?raw=true" alt="hapmap_logo" width="200"/>
HapMap is a sensory navigation application that makes independent travel more accessible for low-vision individuals. It utilizes a combination of auditory, haptic, and vibration cues to inform users of their route. For example: as the user approaches a turn, the frequency of the haptic feedback increases to indicate their proximity to the turn. This reduces the uncertainty that comes with standard navigation systems that may abruptly give instructions.

## Repo Layout
**HapMap/lib**: Files to run, edit, and integrating Google Map API to the flutter app \
- **HapMap/lib/API/** Files related to Google Maps API endpoint and returned data structures \
- **HapMap/lib/pages** Layouts and functionality for front-end UI \
- **HapMap/lib/constants.dart** global constants \
- **HapMap/lib/main.dart** Application entry point \
**HapMap/reports**: Weekly reports and meeting agenda

## How to Build
1. Clone the repository
2. Create private folder in the api directory called .key such that the path is `/api/.key`
3. Add one API key for Google Places and Directions to a dart file in `/api/.key` such that `MAPS_API_KEY="API KEY"`
4. Open an iOS or Android emulator or connect a physical device (such as in Android Studio)
5. In the command line, navigate to the HapMap directory and run 'bash clean_and_run.sh' to build the app

## How to Test
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
