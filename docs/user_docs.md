# User Documentation

## What is HapMap (high-level description)
HapMap is a sensory navigation mobile application that makes independent travel more accessible for low-vision individuals.
It utilizes a combination of auditory, haptic, and vibration cues to inform users of their route.
This reduces the uncertainty that comes with standard navigation systems that may abruptly give instructions. The application
supports searching for locations and helping provide real-time feedback to the user through these mediums, through a simple
user interface.

## Installation
HapMap is available for Android on our official Github Repository and the Google Play Store (link in progress)! It is not currently released for iOS.

### Install from the Repository
Navigate to our [most recent build release](https://github.com/Hap-Map/HapMap/releases), download the APK file, and follow [this article's](https://www.lifewire.com/install-apk-on-android-4177185) directions to install the app on your android device.

## Run HapMap

Whenever you need walking directions to a destination, the HapMap app can be quite useful. To start up the app, follow the following instructions:
### For Android:
Go to your smartphone's app drawer and navigate to the HapMap app. If you are having trouble finding the app, you can try these options:
- Ask the Google Assistant
- Use your smartphone's built-in search functionality to find and open the app.

### For iOS:
Navigate to the HapMap app on the home screen pages. If the app is not visible there, you can try these options:
- Ask Siri to open the app
- Use the search functionality (by dragging downwards on the home screen)
- Navigate to the list of all apps (after the last home screen page) to find and open the app.

If you still cannot find the app on your smartphone, verify that you followed the steps in the [Installation section](#Installation), otherwise contact us for further troubleshooting.


## Use HapMap

Once you have started the HapMap app, location permission will requested in order for you to get correct directions based on your location. You will need to provide permission for precise location updates while using the app in order for the app to work. If you deny permission, the system app settings page will be opened up so that you can manually allow the requested permission.
You can then enter the desired destination and a list of suggestions will be shown (Figure 1).

Figure 1: 
![Alt text](../images/SearchScreenHapMap.png?raw=true "Figure 1")

If you are using TalkBack/VoiceOver, the app is designed for intuitive interactions with dictation services.
Once a particular destination is selected, you will be redirected to a confirmation page where you can see the destination, the name of the current location, and the estimated time it will take to reach the destination (Figure 2).

Figure 2: 
![Alt text](../images/DestinationHapMap.png?raw=true "Figure 2")

When you click the "Start Navigation" button, the navigation starts and the directions and destination are displayed on the screen. The current location keeps updating as you move (Figure 3).

Figure 3: 
![Alt text](../images/NavigationHapMap.png?raw=true "Figure 3")

Whenever you reach the next step, your phone will vibrate, give haptic feedback, and display (or announce, if using dictation services) the next direction.
For the in-app tutorial, you can go to the help section from the search page (the "?" floating button on the lower-right corner).


## Report a Bug

If you encounter a bug when running/using HapMap, please submit a bug report to help us improve. You can find the bug report template by navigating to the "Issues" tab. Click on "New Issues" and then "Get Started" to write a bug report.
<img src="https://media.discordapp.net/attachments/780970726781222943/975990525465341972/Screen_Shot_2022-05-16_at_10.17.48_PM.png?width=2092&height=470" alt="Issues page" width="1000"/>
<img src="https://media.discordapp.net/attachments/780970726781222943/975990607061327993/Screen_Shot_2022-05-16_at_10.18.09_PM.png?width=2092&height=443" alt="get started" width="1000"/>

In the bug report template, we will ask you for a description of the bug, the earliest Version of HapMap with what the problem can be reproduced, how to reproduce the bug, the actual & expected results, screenshots of the bug, desktop or smartphone device information, and any other relevant context. Please follow the instructions in the template to fill out the report, and we really appreciate your time and efforts in filling it out! Thank you!


## Known Bug

You can also navigate to the ["Issues" tab](https://github.com/Hap-Map/HapMap/issues) following the above instructions to find out the current/identified bugs by developers and other users. Currently, because we are still in the process of implementing HapMap, most of the issues are around implementing the full functionality of HapMap. You can expect those usability/implement issues to be solved by the final release date. Otherwise, some known bugs include:

* [Direction iterator misses next que](https://github.com/Hap-Map/HapMap/issues/72)
* [Haptic Touch missing from navigation](https://github.com/Hap-Map/HapMap/issues/45)
