# Team Report

## Last Week's Goals
We planned on finishing the essential features and pages of the application for the upcoming beta release. Specifically, this would include a working navigation page and working navigation along a route. This includes tasks like getting and updating directions, styling the page, adding haptic touch, and including text-to-speech for announcements. We will also continue to add tests and work on getting them to run in CI.

## Progress & Issues
We each worked on our respective front-end and back-end tasks. Frontend is finishing the navigation and confirmation pages, such as implementing the user navigation. Backend is fixing API-related issues as they come up. The CI build is now fully functional with usage of Github Secrets. We've also completed our beta release.

Current issues to be addressed are:
- Directions are not being updated during navigation
- Missing spoken directions
- Missing haptic/vibration feedback

## Next Steps
We will continue to build out the features of HapMap such as navigation and haptic feedback. We will also begin to lay out and implement other pages, such as the help and settings pages. In addition, we will continue adding some unit tests as needed.

During our project meeting, we plan on doing progress checks. Then, we will move onto identifying key tasks that still need to be completed and setting deadlines for when each should be done.

# Team Contributions

## Last Week's Goals
- Emily: Figure out how to set up usage of Github secrets in CI. I will also start addressing issues such as missing accessibility tags.
- Puklit: Finish the confirmation page and start work on the navigation page.
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

## Progress & Issues
- Emily: The continuous integration configuration is fixed, so now the CI is fully functional and tests can run. I also worked on identifying and adding accessibility tags to widgets in the app.
- Pulkit:
- Simona:
- Lauren: Learned how to use the Android simulator to demo route. Helped to try to solve the issue of the API key and github CI build. Created directions iterator for navigation. Found the issue with navigation steps not updating (not fixed yet but we at least know where the bug is)
- Aditya:
    - Implemented active loading, updates, and passing of locations, direction, and estimated time across all pages whenever user's location changes so that the user can see their current location and get updated steps based on the new location. 
    - Worked on location listeners so that they are triggered correctly and start on app launch.
    - Implemented opening of app settings if location permission is denied.
- Jesse:

## Next Steps
- Emily: I will start implementing other aspects of the app, such as the settings or help pages. I will also continue to do periodic manual accessibility testing as more features are added.
- Pulkit:
- Simona:
- Lauren: Work on resolving issue of iterating through navigation steps. This needs some planning as far as implementation and use cases go as it involves multiple parts of our program working together simultaneously. Once that's fixed it would be great to start adding some more tests for testing the API endpoints and the iterator so we can ensure expected behavior.
- Aditya:
    - Working on the use case when the user denies location permission even after app settings is launched.
    - Adding the vibration API.
    - Adding the haptic touch API.
- Jesse:
