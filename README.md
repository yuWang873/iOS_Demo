# iOS Assignment
IBI skill test

## Description

This application was created with SwiftUI that contains follwoing features:
   * 1st page has one button to jump to next page
   * 2nd page shows mapview, and can click button to show annotations with data provided by test_annotations.json
   * 2nd page have a button to draw a polyline connecting the geo-location points with data provided by test_polyline.json
   * When clicked the annotations, 3rd page pops up and display the name of the annontation and its descriptions
   * On the 3rd page, there is a back button that ask yes/no, if yes was clicked, dimiss the 3rd page and can go back to 1st page by clicking the back button at top left corner


## Getting Started

### Dependencies

* iOS 14.0

### Installing

Need to add following description to the info.plist
* Privacy - Location Always and When In Use Usage Description
* Privacy - Location When In Use Usage Description

### Executing program

* Build and run the application on the simulator
* Set the simulator locations to "lat":43.64852093920521, "lon":-79.38019037246704,


## Authors

Yu Wang 

## Version History

* 0.1
    * Initial Release

## Acknowledgments

Inspiration, code snippets, etc.
* [mapKitCoordinator](https://gist.github.com/shaundon/00be84deb3450e31db90a31d5d5b7adc)
