# Team Report

## Last Week's Goals
Focus on learning or reviewing Flutter and Dart. For front-end developers, plan to work on creating basic wireframes and designs. For back-end developers, plan to work on exploring Google APIs for the project.

During our project meeting, we plan on first discussing any remaining concerns about software tools. Then, we will move onto reviewing the timeline for our project and the different tasks we will work on. At this point we might ask for some feedback from the project manager to help gauge which areas of the project might need the most attention.

## Progress & Issues
We each worked on our respective front-end and back-end tasks. We currently have a fully setup working environment for our application implementation as well as a polished UI through Figma. 
The frontend is currently implementing the various pages and has the basic skeleton programmed, and the backend is currently exploring the APIs to be used.
- Everyone has their environment set up
- Implemented basic layout of all the pages on Flutter
- Implemented TypeAhead Searchbar (only provides hard-code suggestions currently)
- Not yet decided on the theme and colors of the application, but plan to choose visually-accessible colors.

## Next Steps
We plan on finishing the basic layout of our app within Flutter (i.e. transfer our Figma design's buttons, text, etc.) and start implementing various features. For the backend, we hope to get some workable data which we can test with our functions once they are implemented.
- Work on integrating the Places Autocomplete API for our suggestions
- Decide on and develop consistent styles, themes, icon(s) for our app
- Add speech-to-text for audio input
- Add widgets/text to the remaining pages

# Team Contributions

## Last Week's Goals
- Emily: I plan on continuing to explore Flutter and Dart, as well as starting to work on the layout and wireframes for the application. This could be done through simple sketches, figma wireframes, or even simple layouts on Flutter.
- Pulkit: Work on a Flutter prototype and explore/integrate libraries and APIs we will use.
- Simona: I will work on styling the search page of the Flutter App
- Lauren:
  - Enable Google Navigation API
  - Prepare request to Navigation API. Start with hard coding then make dynamic based on current location and search.
  - Organize response recieved into data that can be used by other parts of the application.  The data we can expect to receive includes: step-by-step directions (including HTML instructions and lat/long endpoints), ETA, total distance
  - Goals beyond next week:
    - Using the returned data from Google Navigation API, come up with a way to integrate Flutter location and haptic touch
    - Determine how app should handle when a user takes a wrong turn
    - Refine location for input and destination search (Google Places API)
- Aditya:
  - Working on getting more familiarity with Flutter and Dart
  - Starting Google Maps API integration into our project
  - Working on other backend tasks and other project modules
- Jesse: Increase understanding of Flutter, Dart, and any additional relevant packages and libraries that could serve useful in our project. Focus on creating basic wireframes and design for application.

## Progress & Issues
- Emily: This week I have been learning more about how to use Dart/Flutter, exploring what widgets are available, and preparing sketches of the app. I added the TypeAhead widget to the search page to allow for auto-suggestions when the user is entering a query. Further work on this feature would be to make it visually appealing as well as connect it to the Google API and other pages of the app.
- Pulkit: Built a basic layout for each page in Flutter and added routes to finish the app's basic view flow.
- Simona: I finished styling the search page (the background color, search bar, buttons) and added the autofill after selecting a suggestion option
- Lauren: Integrated the Google Navigation API and created directions model.
- Aditya: Learned to work with Flutter and Dart, researched about more accessible app design and structure for screen-readers, and started working on speech-to-text integration.
- Jesse: Designed the main Figma wireframe for our application and wrote draft for weekly report.

## Next Steps
- Emily: Developing the initial layout and functionality of widgets for the navigation confirmation page and communicating with backend developers to facilitate integration of the Google APIs.
- Pulkit: Add functionality and styling to existing widgets, connect widgets with controllers and models.
- Simona: I will work on creating the setting page on Flutter, based on the wireframe Jesse designed last week
- Lauren: 
  - Implement Places API for suggestion search
  - Create Place data object
  - Use Place object returned from search and enable place_id search from Directions API
  - Goals beyond next week
    - Get Maps API working for background of UI. Using polylines we want to be able to show the route which will update in real time using a users location
- Aditya:
  - Working on implementing speech-to-text integration for the search bar
  - Working on finding the route between two locations using the Directions API
  - Integrating accessible design principles into the app modules
- Jesse: Design an additional settings page for our application and start implementing various parts of the app through flutter.