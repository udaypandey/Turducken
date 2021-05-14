//
//  File.swift
//  
//
//  Created by Érik Escobedo on 24/05/21.
//

import Foundation

public struct FanMakerSDKHttp {
    public static func get<HttpResponse: FanMakerSDKHttpResponse>(path : String, model: HttpResponse.Type, onCompletion : @escaping (Result<HttpResponse, FanMakerSDKHttpError>) -> Void) {
        let request = FanMakerSDKHttpRequest(path: path)
        request.get(model: model.self, onCompletion: onCompletion)
    }
}
