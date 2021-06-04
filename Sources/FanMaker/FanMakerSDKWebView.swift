//
//  File.swift
//  
//
//  Created by Érik Escobedo on 28/05/21.
//

import Foundation
import SwiftUI
import WebKit

let FanMakerSDKSessionToken : String = "FanMakerSDKSessionToken"

@available(iOS 13.0, *)
public struct FanMakerSDKWebView : UIViewRepresentable {
    public var webView : WKWebView
    private var urlString : String = ""

    public init(configuration: WKWebViewConfiguration) {
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        
        let path = "site_details/info"
        
        let semaphore = DispatchSemaphore(value: 0)
        var urlString : String = ""
        DispatchQueue.global().async {
            FanMakerSDKHttp.get(path: path, model: FanMakerSDKSiteDetailsResponse.self) { result in
                switch(result) {
                case .success(let response):
                    urlString = response.data.sdk_url
                case .failure(let error):
                    print(error.localizedDescription)
                    urlString = "https://admin.fanmaker.com/500"
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        
        self.urlString = urlString
    }
    
    public func prepareUIView() {
        let defaults : UserDefaults = UserDefaults.standard
        var urlString = self.urlString
        if let token = defaults.string(forKey: FanMakerSDKSessionToken) {
            urlString += "?token=\(token.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        }
        
        let url : URL? = URL(string: urlString)
        var request : URLRequest = URLRequest(url: url!)
        request.setValue(FanMakerSDK.apiKey, forHTTPHeaderField: "X-FanMaker-Token")
        request.setValue(FanMakerSDK.memberID, forHTTPHeaderField: "X-Member-ID")
        request.setValue(FanMakerSDK.studentID, forHTTPHeaderField: "X-Student-ID")
        request.setValue(FanMakerSDK.ticketmasterID, forHTTPHeaderField: "X-Ticketmaster-ID")
        request.setValue(FanMakerSDK.yinzid, forHTTPHeaderField: "X-Yinzid")
        
        self.webView.load(request)
    }
    
    public func makeUIView(context: Context) -> some UIView {
        prepareUIView()
        return self.webView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
