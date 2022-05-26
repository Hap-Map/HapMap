# Team Report

## Last Week's Goals
We will continue to build out the features of HapMap such as navigation and haptic feedback. We will also continue implementing other pages, such as the settings pages. In addition, we will continue adding some unit tests as needed.

## Progress & Issues
We each worked on our respective front-end and back-end tasks as well as debugging features. We have also started adding features such as shaking and text-to-speech for the navigation.

There are no critical issues at the moment, any issues are bugs in our current features that are actively being worked on.

## Next Steps
Current tasks consist primarily of integrating newly updated features. For the final release next week, we also plan on polishing the UI and making sure everything works.

- Directions/Navigation should be mostly working as expected now (PRs pending)
- Shaking callbacks are working on iOS devices (PR pending)
- Directions are spoken using TTS when the next instruction is loaded (to-be-merged + tested)

During our project meeting, we'll do some progress checks on remaining features, identify talking points for the final release demo, and divide tasks.

# Team Contributions

## Last Week's Goals
- Emily: I will work on making sure the directions are announced to the user automatically (regardless of using screen reader). Currently there is no auditory feedback, the user has to look at the screen to see the next direction.
- Pulkit: Test to see if directions match up and complete navigation page, add implementation of onShake()
- Simona: Finish implementing the shake response, help with settings page and tutorial page
- Lauren: Work on the directions bug as stated above. Can also help with implementing haptic touch as this feature uses the directions iterator.
- Aditya:
  - Adding the vibration API.
  - Adding the haptic touch API.
  - Working on the use case when the user denies location permission even after app settings is launched.
- Jesse: Finish the implementation for the settings page and work on tutorial pages.

## Progress & Issues
- Emily: Added TTS to the navigation page for directions to be announced. I also updated the documentation to be clearer for developers.
- Pulkit:
- Simona:
- Lauren:
- Aditya: Implemented the haptic touch API and started working on vibration. Also working on implementing and testing shake response on navigation page.
- Jesse: Implemented settings page, currently working on tutorial pages

## Next Steps
- Emily: I will continue updating the documentation as needed based on observations from peer review. I'll also investigate issues brought up from the peer review as needed.
- Pulkit:
- Simona:
- Lauren:
- Aditya: Completing the vibration API and working on implementation of both in the app depending on user settings.
- Jesse: Try to implement the updated tutorial pages for new users and make any modifications to previous features
