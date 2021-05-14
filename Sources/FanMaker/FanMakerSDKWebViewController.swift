//
//  File.swift
//  
//
//  Created by Érik Escobedo on 28/05/21.
//

import Foundation
import WebKit
import CoreLocation

@available(iOS 14.0, *)
public class FanMakerSDKWebViewController : NSObject, WKScriptMessageHandler {
    public var view : FanMakerSDKWebView? = nil
    private let locationManager : CLLocationManager = CLLocationManager()
    private let locationDelegate : FanMakerSDKLocationDelegate = FanMakerSDKLocationDelegate()
    
    public override init() {
        super.init()
        
        let userController : WKUserContentController = WKUserContentController()
        userController.add(self, name: "fanmaker")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        
        self.view = FanMakerSDKWebView(configuration: configuration)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "fanmaker", let body = message.body as? Dictionary<String, String> {
            let defaults : UserDefaults = UserDefaults.standard

            body.forEach { key, value in
                switch(key) {
                case "setToken":
                    defaults.set(value, forKey: FanMakerSDKSessionToken)
                case "requestLocationAuthorization":
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.delegate = locationDelegate
                    locationManager.requestLocation()
                case "updateLocation":
                    if CLLocationManager.locationServicesEnabled() {
                        switch locationManager.authorizationStatus {
                        case .notDetermined, .restricted, .denied:
                            print("Access Denied")
                        case .authorizedAlways, .authorizedWhenInUse:
                            view!.webView.evaluateJavaScript("receiveLocation(\(locationDelegate.coords()))")
                        @unknown default:
                            print("Unknown error")
                        }
                    } else {
                        print("CLLocationManager.locationServices are DISABLED")
                    }
                default:
                    break;
                }
            }
        }
    }
}
