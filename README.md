# iOS Assignment
IBI skill test

## Description

This application was created with SwiftUI and MKMapView that contains follwoing features:
   * 1st page has one button to jump to next page
   * 2nd page shows mapview, and can click button to show annotations with data provided by test_annotations.json
   * 2nd page have a button to draw a polyline connecting the geo-location points with data provided by test_polyline.json
   * When clicked the annotations, 3rd page pops up and display the name of the annontation and its descriptions
   * On the 3rd page, there is a back button that ask yes/no, if yes was clicked, dimiss the 3rd page and can go back to 1st page by clicking the back button at top left corner


## Getting Started

### Dependencies

* iOS 14.0

### Installing
Need to add following  libraries:
* swiftui-navigation-stack from https://github.com/matteopuc/swiftui-navigation-stack

Need to add following frameworks:
* Mapkit.framework

Need to add following description to the info.plist
* Privacy - Location Always and When In Use Usage Description
* Privacy - Location When In Use Usage Description

### Executing program

* Build and run the application on the simulator
* On the 1st page, click the map icon to go to next page
* On the 2nd page, click the mappin button to show annotations, click the plus button to show polyline
* Click the annotations to show details, and click the i icon to display 3rd page
* On the 3rd page, click the back arrow button to go back to 1st page


## Authors

Yu Wang 

## Version History

* 0.1
    * Initial Release

## Acknowledgments

Inspiration, code snippets, etc.
* [mapKitCoordinator](https://gist.github.com/shaundon/00be84deb3450e31db90a31d5d5b7adc)
