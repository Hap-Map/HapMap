# Team Report

## Last Week's Goals
We will continue to build out the features of HapMap such as navigation and haptic feedback. We will also begin to lay out and implement other pages, such as the help and settings pages. In addition, we will continue adding some unit tests as needed.

## Progress & Issues
We each worked on our respective front-end and back-end tasks. Frontend is building out user documentation and settings. Cross-team collaboration is happening to debug nagivation and directions ordering. We have also started adding features such as shaking.

Current issues to be addressed are:
- Directions/navigation is not fully functioning yet
- Missing spoken directions
- Missing haptic/vibration feedback

## Next Steps
We will continue to build out the features of HapMap such as navigation and haptic feedback. We will also continue implementing other pages, such as the settings pages. In addition, we will continue adding some unit tests as needed.

During our project meeting, we plan on doing progress checks. Then, we will move onto identifying key tasks that still need to be completed and setting deadlines for when each should be done.

# Team Contributions

## Last Week's Goals
- Emily: I will start implementing other aspects of the app, such as the settings or help pages. I will also continue to do periodic manual accessibility testing as more features are added.
- Pulkit: Debug navigation page, finish basic functional implementation of the app
- Simona: Build on setting pages if needed, work with other team members on finishing up the haptic feedback
- Lauren: Work on resolving issue of iterating through navigation steps. This needs some planning as far as implementation and use cases go as it involves multiple parts of our program working together simultaneously. Once that's fixed it would be great to start adding some more tests for testing the API endpoints and the iterator so we can ensure expected behavior.
- Aditya: Working on adding the shake API with the ability to add listeners and other related methods.
- Jesse: Will work on the navigation page to fix up any issues and/or implement the tutorial pages.

## Progress & Issues
- Emily: Implemented the Help page, connecting it to the search page and adding documentation for the user. There are currently no issues, just need to link an interactive tutorial once it is completed.
- Pulkit: Fixed overflow issue on help page, sizing issue on confirm page, added to developer documentation.
- Simona: Removed mic button, added accessibility labels, added a few keys for widget testing. Added widget tests for confirmation & navigation page but it's not working yet because the test is not waiting for the API call to return.
- Lauren: Got the directions display working! Still a minor bug when determining when to move to the next step if the app doesn't detect if user has reached instruction step end (this may just be a bug with the simulator and not actually affect use but should still be looked at anyways as it may impact haptic touch). Also was able to add some places API end point tests and documentation
- Aditya: Implemented the shake API with the ability to add listeners and started initialization and detection on the search_page. Implemented functionality on the navigation_page such that the onShake method will get called whenever user shakes device. Also worked on the user documentation.
- Jesse: Implementing settings page according to new design preferences and helped write user documentation.

## Next Steps
- Emily: I will work on making sure the directions are announced to the user automatically (regardless of using screen reader). Currently there is no auditory feedback, the user has to look at the screen to see the next direction.
- Pulkit: Test to see if directions match up and complete navigation page, add implementation of onShake()
- Simona: Finish implementing the shake response, help with settings page and tutorial page
- Lauren: Work on the directions bug as stated above. Can also help with implementing haptic touch as this feature uses the directions iterator.
- Aditya:
  - Adding the vibration API.
  - Adding the haptic touch API.
  - Working on the use case when the user denies location permission even after app settings is launched.
- Jesse: Finish the implementation for the settings page and work on tutorial pages.
