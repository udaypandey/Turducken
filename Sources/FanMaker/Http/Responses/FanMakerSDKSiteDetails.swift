//
//  File.swift
//  
//
//  Created by Érik Escobedo on 24/05/21.
//

import Foundation

public struct FanMakerSDKBeacons : Decodable {
    public let beaconUniquenessThrottle : String
}

public struct FanMakerSDKSiteFeatures : Decodable {
    public let beacons : FanMakerSDKBeacons
}

public struct FanMakerSDKSiteDetails : Decodable {
    public let canonical_url : String
    public let sdk_url : String
    public let site_features : FanMakerSDKSiteFeatures
}

public struct FanMakerSDKSiteDetailsResponse : FanMakerSDKHttpResponse {
    public let status : Int
    public let message : String
    public let data : FanMakerSDKSiteDetails
}
