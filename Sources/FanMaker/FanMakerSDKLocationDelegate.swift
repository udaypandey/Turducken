//
//  File.swift
//  
//
//  Created by Érik Escobedo on 31/05/21.
//

import Foundation
import CoreLocation

class FanMakerSDKLocationDelegate : NSObject, CLLocationManagerDelegate {
    public var lat : CLLocationDegrees
    public var lng : CLLocationDegrees
    
    override init() {
        self.lat = 0
        self.lng = 0
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager didUpdateLocations")
        if let location = locations.first {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            self.lat = location.coordinate.latitude
            self.lng = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    public func coords() -> String {
        return "{\"lat\":\(self.lat), \"lng\":\(self.lng)}"
    }
}
