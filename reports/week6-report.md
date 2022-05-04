# Team Report

## Last Week's Goals
We plan on finishing the basic layout of our app within Flutter (i.e. transfer our Figma design's buttons, text, etc.) and start implementing 
features such as navigation and haptic/vibration feedback. For the backend, we hope to get some workable data which we can test with our functions 
once they are implemented, as well as expanded functionality to format data on displays.
- Work on getting addresses from lat/long values, and vice versa
- Explore how to integrate a map UI from Google
- Add speech-to-text for audio input
- Add widgets/text to the remaining pages

## Progress & Issues
We each worked on our respective front-end and back-end tasks. Frontend is finishing the navigation and confirmation pages, such as implementing the user navigation. Backend is setting up APIs for integration with navigation and fixing API-related issues as they come up. A continuous integration pipeline has also been added, along with unit tests.

Current issues to be addressed are:
- Location listeners are not being triggered in latest commits
- Widgets are missing accessibility tags for screen-readers
- Unit tests fail in CI due to missing API key

## Next Steps
We plan on finishing the essential features and pages of the application for the upcoming beta release. Specifically, this would include a working navigation page and working navigation along a route. This includes tasks like getting and updating directions, styling the page, adding haptic touch, and including text-to-speech for announcements. We will also continue to add tests and work on getting them to run in CI.

During our project meeting, we plan on doing progress checks. Then, we will move onto identifying key tasks that still need to be completed and setting deadlines for when each should be done. A third topic to consider is how to record the demo for the beta release.

# Team Contributions

## Last Week's Goals
- Emily: I will assist in styling and implementation of other pages and address bugs (moving them to github issues as needed):
   - The submit/go button for search queries should be consistent with app styling
   - Users should not be able to submit an empty search query
- Pulkit: Complete flow of arguments from confirm page to navigation page, finish confirm page and help with navigation page's layout and widgets.
- Simona: I will work on creating the setting page on Flutter, based on the wireframe Jesse designed last week
- Lauren:
    - Get Maps API working for background of UI
    - Draw polylines from route onto map
    - Integrate location with Maps API
    - Work on backend testing suite for API endpoints to make sure APIs work as expected
- Aditya:
    - Implementing speech-to-text integration for the search bar
    - Adding a text-to-speech API for the app
- Jesse: Start implementing the main navigation pages

## Progress & Issues
- Emily: We decided to forgo the 'submit' button on the search page and instead only submit if a user selects one of the suggested locations, so I shifted to setting up widget tests and continuous integration on Github. Current issues with CI are how some API-related tests rely on the API key. I also helped with updating the confirmation page to display the user's current address instead of latitude/longitude values.
- Puklit:
- Simona:
- Lauren:
- Aditya:
- Jesse: Successfully implemented the navigation page main layout to match the Figma. Current trying to fix spacing issues and to format padding/spacing for all devices.

## Next Steps
- Emily:
- Puklit:
- Simona:
- Lauren:
- Aditya:
- Jesse: Perfect the navigation page UI interface through changing spacing and start working on the tutorial pages once complete.
