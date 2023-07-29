# animal-swiftui

This project demonstrates a basic SwiftUI app where we make some API requests and the user can scroll vertically or horizontally on the available content. <br />
# Software Design Pattern: 
The project is using MVVM structure to separate the state and logic out of our view structs. <br />

# Used libraries: 
**Firebase** for Push Notification <br />
**SDWebImage** to present and cache images.

# Network Requests
I have implemented three different ways to fetch the data. <br />
Closures <br />
Combine <br />
Async Await <br />

While all the ways are available in the view model, I preferred to use the async await as it is the modern way to handle requests and it is easier to grasp the calls due to its' easy structure.

# SwiftUI / UIKit Interoperability
Even though SwiftUI is the future of iOS development, there are still plenty of projects in UIKit. In this project, I wanted to demonstrate a simple of how can use these frameworks together. <br />

SettingsViewController is UIKit class and I created a WelcomeVideoView SwiftUI struct and embedded UIKit component in it. <br />
Inside SettingsViewController I wanted to present a VideoPlayer which is a SwiftUI component. Using UIHostingController I am able to use that SwiftUI view in UIKit. <br />

Similarly, CameraImagePicker which has UIImagePickerController  is used in our SwiftUI view.

# SwiftUI Animations
Creating animations in SwiftUI is straight forward and loading animation is a common usage that is used in popular apps such as Facebook, Twitter while loading the content. I set up a similar gradient animation as a placeholder while loading the images.

## Animations with Motion Manager
iPhone devices are able to detect certain motions in the device using the accelerometer and the the gyroscope hardware. I have made use of this feature and implemented a 3D rotation of images effect using the values from the different axes. <br />

# Accessibility Feature
In this project, I had a chance to experiment with the following features:
**accessibilityLabel**: Create a custom label to announce  <br />
**accessibilityRemoveTraits**: Remove default object type from accessibility  <br />
**accessibilityHidden**: Hide some views from accessibility. (Irrelevant features or views)  <br />
