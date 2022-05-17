# Developer documentation

## Obtain the Source Code
Navigate to the "Code" button on the repository. Ensure it is on the main branch. Clone the repository to your local machine accordingly, following [Github's official Documentation](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) as needed. You should be able to now open the project in your IDE of choice (ours is Android Studio).

## Directory Layout
* **lib** - contains all the source code
  * **api** - API related constants and controllers
    * **.key** - holds private keys, ignored by .gitignore 
      * **actions.dart** - API key for Github actions
      * **maps.dart** - API key for Google Maps
    * **directions_api.dart** - Controller for Google Directions API
    * **location_api.dart** - Controller for GeoLocator 
    * **place_api.dart** - Controller for Google Places API
  * **models** - stores navigation data
    * **directions_model.dart** - Model for Directions, Steps, and DirectionIterator
    * **place_model.dart** - Model for a Place
  * **pages** - flutter code with all the front-end design
    * **search_page.dart** - home-page where user enters a place for navigation
    * **confirm_page.dart** - user confirms their destination details
    * **navigation_page.dart** - user navigates to their destination, with navigation cues dictating the route
    * **settings_page.dart** - user controls app settings like haptic/vibrations/shake etc.
  * **constants.dart** - holds constant widget data to be accessed from all the pages
  * **main.dart** - initializes the app, defines the routes/flow of the app
* **images** - contains image data for the app
  * **hapmap_logo.png** - hapmap logo
* **ios** - contains build data for the ios app
  * **Runner/AppDelegate.swift** - provide the Google Maps API key here
  * **Podfile** - defines the dependencies for the xcode project
* **android** - contains build data for the android app
  * app/src/main/AndroidManifest.xml - provide the Google Maps API key here
* **docs** - Documentation for HapMap
  * **developer_docs.md** - documentation for developers
  * **user_docs.md** - documentation for users
* **test** - unit tests for HapMap
  * **directions_test.dart** - tests for the directions api & model
  * **places_test.dart** - tests for the places api & model
  * **widget_test.dart** - tests for flutter widgets
* **clean_and_run.sh** - cleans, rebuilds, and runs flutter (must have a device open)
* **pubspec.yaml** - declare the applications library, assets, and sdk dependencies
## Build HapMap

## Test HapMap

## Add New Tests
New tests can be added under the lib/test folder, either by adding a new .dart file or creating a new test case under an existing file. Tests that use the directions API or places API can be added to the directions_test.dart and places_test.dart files respectively. New test files should import the Dart/Flutter test package (https://pub.dev/packages/test). Network requests sent to the APIs are not tested but the resulting data members are. Models are tested via unit tests and compared using hard coded values expected to result from the returned json string. This is to ensure all data returned from APIs follows the expected format used by the rest of the application.
To test for equivalency, models have a built in equals method that can be used with the expect method from the dart/flutter test package. Instead of using the location service API, hard coded co-ordinate points can be used as a parameter using the LatLng package (https://pub.dev/packages/latlng) to simulate a user's location for any method that relies on this service.  

## Build Release
