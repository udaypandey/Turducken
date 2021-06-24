//
//  File.swift
//  
//
//  Created by Érik Escobedo on 28/05/21.
//

import Foundation
import CoreLocation
import WebKit
import SwiftUI

@available(iOS 13.0, *)
public class FanMakerSDKWebViewController : UIViewController, WKScriptMessageHandler {
    public var fanmaker : FanMakerSDKWebView? = nil
    private let locationManager : CLLocationManager = CLLocationManager()
    private let locationDelegate : FanMakerSDKLocationDelegate = FanMakerSDKLocationDelegate()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let userController : WKUserContentController = WKUserContentController()
        userController.add(self, name: "fanmaker")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        
        self.fanmaker = FanMakerSDKWebView(configuration: configuration)
        self.fanmaker?.prepareUIView()
        self.view = self.fanmaker!.webView
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
                    if FanMakerSDK.locationEnabled && CLLocationManager.locationServicesEnabled() {
                        var authorizationStatus : CLAuthorizationStatus
                        if #available(iOS 14.0, *) {
                            authorizationStatus = locationManager.authorizationStatus
                        } else {
                            authorizationStatus = CLLocationManager.authorizationStatus()
                        }
                        
                        switch authorizationStatus {
                        case .notDetermined, .restricted, .denied:
                            print("Access Denied")
                            fanmaker!.webView.evaluateJavaScript("receiveLocationAuthorization(false)")
                        case .authorizedAlways, .authorizedWhenInUse:
                            fanmaker!.webView.evaluateJavaScript("receiveLocation(\(locationDelegate.coords()))")
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

@available(iOS 13.0, *)
public struct FanMakerSDKWebViewControllerRepresentable : UIViewControllerRepresentable {
    public init() {}

    public func makeUIViewController(context: Context) -> some UIViewController {
        return FanMakerSDKWebViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

