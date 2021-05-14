//
//  File.swift
//  
//
//  Created by Érik Escobedo on 24/05/21.
//

import Foundation

public struct FanMakerSDKSiteDetails : Decodable {
    public let canonical_url : String
    public let sdk_url : String
}

public struct FanMakerSDKSiteDetailsResponse : FanMakerSDKHttpResponse {
    public let status : Int
    public let message : String
    public let data : FanMakerSDKSiteDetails
}
