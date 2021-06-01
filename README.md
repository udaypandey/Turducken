# FanMaker Swift SDK for iOS App Development 

## About

The FanMaker Swift SDK provides iOS developers with a way of inserting an iOS View displaying their own FanMaker's Program. This view can be displayed as part of a navigation stack, as well as a modal or even a subview into your app's layout.

## Usage

First of all, you need to contact FanMaker in order to get and `<SDK_KEY>`. This key is linked to your FanMaker program and it's used to initialize the SDK so it can display your very own FanMaker content.

Then, you need to add the FanMaker SDK to your project as a Swift Package:

![Captura de Pantalla 2021-06-01 a la(s) 10 54 06](https://user-images.githubusercontent.com/298020/120363801-2f743e00-c2d2-11eb-89fb-3fd273072d16.png)

![Captura de Pantalla 2021-06-01 a la(s) 12 09 52](https://user-images.githubusercontent.com/298020/120363926-4c107600-c2d2-11eb-8374-0b7e9cfc21a4.png)

### Initialization

To initialize the SDK you need to pass your `<SDK_KEY>` into the FanMaker SDK initializer. You need to call this code in your `AppDelegate` class as part of your `application didFinishLaunchingWithOptions` callback function. Things are a little different depending on what "Life Cycle" are you using.

#### For UIKit

If you're using `UIKit` then you should already have and `AppDelegate` class living in `AppDelegate.swift`, so you just need to add FanMaker SDK initialization code to that file under the right callback function:

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

and then you need to add the `AppDelegate` class to your `@main` file:

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

In order to show FanMaker UI in your app, you need to create an instance of `FanMakerSDKWebViewController` and use it's `view` property as you find convenient. `FanMakerSDKWebViewController`'s `view` property complies with `UIViewRepresentable` protocol so it can be used in any way covered by that protocol. For example, the following code is used to show it as a sheet modal when users press a button:

```
import SwiftUI
import FanMaker

struct ContentView : View {
    @State private var isShowingFanMakerUI : Bool = false
    
    var body : some View {
        // FanMakerUI initialization
        let fanMakerUI = FanMakerSDKWebViewController()
        
        Button("Show FanMaker UI", action: { isShowingFanMakerUI = true })
            .sheet(isPresented: $isShowingFanMakerUI) {
                // FanMakerUI Display
                fanMakerUI.view
                Button("Hide FanMakerUI", action: { isShowingFanMakerUI = false })
            }
    }
}
``
