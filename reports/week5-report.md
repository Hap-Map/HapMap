# Team Report

## Last Week's Goals
We plan on finishing the basic layout of our app within Flutter (i.e. transfer our Figma design's buttons, text, etc.) and start implementing various features. For the backend, we hope to get some workable data which we can test with our functions once they are implemented.
- Work on integrating the Places Autocomplete API for our suggestions
- Decide on and develop consistent styles, themes, icon(s) for our app
- Add speech-to-text for audio input
- Add widgets/text to the remaining pages

## Progress & Issues
We each worked on our respective front-end and back-end tasks. We currently have a fully setup working environment for our application implementation as well as a polished UI through Figma. 
The frontend is currently implementing the various pages and has the basic skeleton programmed, and the backend is currently expanding APIs and models to be used.
- Everyone has their environment set up
- Appearance of UI is decided
- Search and confirmation page are styled and ready to display data (if not already)
- TypeAhead Searchbar auto-completes with real locations/addresses

## Next Steps
We plan on finishing the basic layout of our app within Flutter (i.e. transfer our Figma design's buttons, text, etc.) and start implementing features such as navigation and haptic/vibration feedback. For the backend, we hope to get some workable data which we can test with our functions once they are implemented, as well as expanded functionality to format data on displays.
- Work on getting addresses from lat/long values, and vice versa
- Explore how to integrate a map UI from Google
- Add speech-to-text for audio input
- Add widgets/text to the remaining pages

During our project meeting, we plan on first discussing any remaining concerns about software tools, and then doing progress checks. Then, we will move onto reviewing the timeline for our project and the different tasks we will work on.

# Team Contributions

## Last Week's Goals
- Emily: Developing the initial layout and functionality of widgets for the navigation confirmation page and communicating with backend developers to facilitate integration of the Google APIs.
- Pulkit: Add functionality and styling to existing widgets, connect widgets with controllers and models.
- Simona: I will work on styling the search page of the Flutter App
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

## Progress & Issues
- Emily: This past week I've been working on the confirmation page, styling it to match our wireframe and setting up functions to get information from models. Current issues are that the time estimation and user's current address are not working, which will be resolved this week.
- Pulkit: Fixed bugs in the front-end, cleaned up some of the UI, added arguments from search page --> confirm page.
- Simona: I finished styling the search page (the background color, search bar, buttons) and added the autofill after selecting a suggestion option
- Lauren: Created Place API and place model. Wrote up architecture design doc for backend.
- Aditya: Learned to work with Flutter and Dart, researched about more accessible app design and structure for screen-readers, and started working on speech-to-text integration.
- Jesse: Designed the settings page and helped write additional plans for developer and user documentation for our project within the group document

## Next Steps
- Emily: I will address two bugs in the search page (moving them to github issues as needed):
   - The user should be able to focus/unfocus from the search bar
   - there should be a submit button
- Pulkit: Complete flow of arguments from confirm page to navigation page, finish confirm page and help with navigation page's layout and widgets.
- Simona: I will work on creating the setting page on Flutter, based on the wireframe Jesse designed last week
- Lauren:
    - Get Maps API working for background of UI
    - Draw polylines from route onto map
    - Integrate location with Maps API
    - Work on backend testing suite for API endpoints to make sure APIs work as expected
- Aditya:
  - Working on implementing speech-to-text integration for the search bar
  - Working on finding the route between two locations using the Directions API
  - Integrating accessible design principles into the app modules
- Jesse: Start implementing the main navigation pages
