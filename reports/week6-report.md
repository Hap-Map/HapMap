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
- Simona: worked on integrating API calls (place & direction API) to the confirmation page and navigation page. did not figure it out fully yet. But we have the functions written. Just need to find better ways to pass varaibles between different files.
- Lauren: Started working on tests for the API models. Was able to refactor the models to take an optional parameter for origin so we could test by hardcoding the location. Since the directions model returns very detailed information about routes, getting tests that test for equivalency was difficult. I'm also not sure how to test for some of the edge cases and if the tests are robust enough? I was also able to get a map for the UI going with polylines. The polylines that were drawn using the step points weren't accurate enough (causing the polylines for the route to be off by a noticable amount). Had to work to debug this issue but theyre working now.
- Aditya: We decided to use the inbuilt speech-to-text in the keyboard for now. Started working on adding a vibrations API. Also started debugging the location API and worked on an invalid argument issue that was crashing the app.
- Jesse: Successfully implemented the navigation page main layout to match the Figma. Current trying to fix spacing issues and to format padding/spacing for all devices.

## Next Steps
- Emily: Figure out how to set up usage of Github secrets in CI. I will also start addressing issues such as missing accessibility tags.
- Puklit:
- Simona: will work with Pulkit on fully integrating the APIs to navigation page -> find out ways to offer directions & haptic feedback to user step by step
- Lauren:
    - Continue working on tests for the places and directions (adding more cases)
    - Work on navigation tests + demoing route using location on map
    - Updating documentation
- Aditya:
    - Working on debugging the location listeners so that they are triggered correctly
    - Adding the vibration API
    - Adding the haptic touch API
- Jesse: Perfect the navigation page UI interface through changing spacing and start working on the tutorial pages once complete.
