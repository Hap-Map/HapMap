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

## Build Release
Building a release will depend on the operating system the device uses. This Flutter project can be built for both iOS and Android. Depending on which platform is being used, there may be additional requirements.

See the official Flutter documentation:
* [Build and Release for Android](https://docs.flutter.dev/deployment/android#building-the-app-for-release)
* [Build and Release for iOS](https://docs.flutter.dev/deployment/ios)

As a final sanity check, be sure to download the release onto a device and ensure that everything works as expected.