# FanMaker Swift SDK for iOS App Development 

## About

The FanMaker Swift SDK provides iOS developers with a way of inserting the FanMaker UI in another app. The view can be displayed as part of a navigation stack, a modal or even a subview in an app's layout.

## Usage

First add the FanMaker SDK to your project as a Swift Package:

![xcode1](https://user-images.githubusercontent.com/298020/120363801-2f743e00-c2d2-11eb-89fb-3fd273072d16.png)

![xcode2](https://user-images.githubusercontent.com/298020/120363926-4c107600-c2d2-11eb-8374-0b7e9cfc21a4.png)

### Initialization

To initialize the SDK you need to pass your `<SDK_KEY>` into the FanMaker SDK initializer. You need to call this code in your `AppDelegate` class as part of your `application didFinishLaunchingWithOptions` callback function. Configuration is a little different depending on what "Life Cycle" are you using.

#### For UIKit

If you are using `UIKit` then you should already have and `AppDelegate` class living in `AppDelegate.swift`, so you just need to add FanMaker SDK initialization code to that file under the right callback function:

```
import UIKit
import FanMaker

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        . . .

        // FANMAKER SDK INITIALIZATION CODE
        FanMakerSDK.initialize(apiKey: "<SDK_KEY>")
  
        . . .

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      . . .
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      . . .
    }


}
```

#### For SwiftUI

When using `SwiftUI` Life Cycle, no `AppDelegate` class is created automatically so you need to create one of your own:

```
// AppDelegate.swift

import SwiftUI
import FanMaker

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FanMakerSDK.initialize(apiKey: "<SDK_KEY>")

        return true
    }
}
```

and then add the `AppDelegate` class to your `@main` file:

```
// MyApp.swift

import SwiftUI

 @main
struct MyApp: App {
    // Include your AppDelegate class here
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### Displaying FanMaker UI

In order to show FanMaker UI in your app, create an instance of `FanMakerSDKWebViewController` (`UIViewController` subclass) and use it as you find convenient.

FanMaker SDK also provides a `FanMakerSDKWebViewControllerRepresentable` wrapper which complies with `UIViewControllerRepresentable` protocol. For example, the following code is used to show it as a sheet modal when users press a button (which we recomend):

```
import SwiftUI
import FanMaker

struct ContentView : View {
    @State private var isShowingFanMakerUI : Bool = false
    
    var body : some View {
        Button("Show FanMaker UI", action: { isShowingFanMakerUI = true })
            .sheet(isPresented: $isShowingFanMakerUI) {
                // FanMakerUI Display
                FanMakerSDKWebViewControllerRepresentable()
                Button("Hide FanMakerUI", action: { isShowingFanMakerUI = false })
            }
    }
}
```

#### Personalization options

When you present the `FanMakerSDKWebViewController` instance it will take a couple of seconds to load the content to display to the user. In the meanwhile, a white screen with a loading animation will show to indicate the user the UI is actually loading.

You can personalize both the loading screen's background color and loading animation by calling the following methods before presenting the `FanMakerSDKWebViewController`. The prefered place to call these functions is right after calling `FanMakerSDK.initialize` 

```
FanMakerSDK.setLoadingBackgroundColor(_ bgColor : UIColor)
FanMakerSDK.setLoadingForegroundImage(_ fgImage : UIImage)
```

**Note**: `FanMakerSDK.setLoadingForegroundImage(_ fgImage : UIImage)` can take both a static or an animated `UIImage` as an argument.

### Passing Custom Identifiers

FanMaker UI usually requires users to input their FanMaker's Credentials. However, you can make use of up to four different custom identifiers to allow a given user to automatically login when they first open FanMaker UI.

```
import SwiftUI
import FanMaker

struct ContentView : View {
    @State private var isShowingFanMakerUI : Bool = false
    
    var body : some View {
        // FanMakerUI initialization
        let fanMakerUI = FanMakerSDKWebViewController()
        
        Button("Show FanMaker UI", action: {
            // **Note**: Identifiers availability depends on your FanMaker program.
            FanMakerSDK.setMemberID("<memberid>")
            FanMakerSDK.setStudentID("<studentid>")
            FanMakerSDK.setTicketmasterID("<ticketmasterid>")
            FanMakerSDK.setYinzid("<yinzid>")
            FanMakerSDK.setPushNotificationToken("<pushToken>")
            
            // Enable Location Tracking (Permissions should be previously asked by your app)
            FanMakerSDK.enableLocationTracking()

            // Make sure to setup any custom identifier before actually displaying the FanMaker UI
            isShowingFanMakerUI = true
        })
            .sheet(isPresented: $isShowingFanMakerUI) {
                // FanMakerUI Display
                fanMakerUI.view
                Button("Hide FanMakerUI", action: { isShowingFanMakerUI = false })
            }
    }
}
```

### Location Tracking

FanMaker UI asks for user's permission to track their location the first time it loads. However, location tracking can be enabled/disabled by calling the following static functions:

```
// To manually disable location tracking
FanMakerSDK.disableLocationTracking()

// To manually enable location tracking back
FanMakerSDK.enableLocationTracking()
```
