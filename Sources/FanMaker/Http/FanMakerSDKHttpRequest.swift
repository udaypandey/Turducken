//
//  File.swift
//  
//
//  Created by Érik Escobedo on 24/05/21.
//

import Foundation

public struct FanMakerSDKHttpRequest {
    public static let host : String = "https://api.fanmaker.com/api/v2"
    public let urlString : String
    private var request : URLRequest? = nil
    
    init(path: String) {
        self.urlString = "\(FanMakerSDKHttpRequest.host)/\(path)"
        
        if let url = URL(string: urlString) {
            self.request = URLRequest(url: url)
            self.request?.setValue(FanMakerSDK.apiKey, forHTTPHeaderField: "X-FanMaker-Token")
        }
    }
    
    func get<HttpResponse : FanMakerSDKHttpResponse>(model: HttpResponse.Type, onCompletion : @escaping (Result<HttpResponse, FanMakerSDKHttpError>) -> Void) {
        guard var request = self.request else {
            onCompletion(.failure(FanMakerSDKHttpError(code: .badUrl, message: self.urlString)))
            return
        }
        
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                onCompletion(.failure(FanMakerSDKHttpError(code: .unknown, message: error!.localizedDescription)))
                return
            }
            
            guard let httpResponse : HTTPURLResponse = response as? HTTPURLResponse, let data = data else {
                onCompletion(.failure(FanMakerSDKHttpError(code: .badResponse, message: "Invalid HTTP Response")))
                return
            }
            
            let httpStatusCode : Int = httpResponse.statusCode
            if httpStatusCode == 200 {
                do {
                    let httpResponse : HttpResponse = try JSONDecoder().decode(model.self, from: data)
                    if httpResponse.status == 200 {
                        onCompletion(.success(httpResponse))
                    } else {
                        onCompletion(.failure(FanMakerSDKHttpError(httpCode: httpResponse.status, message: httpResponse.message)))
                    }
                } catch let jsonError as NSError {
                    onCompletion(.failure(FanMakerSDKHttpError(code: .badResponse, message: jsonError.localizedDescription)))
                }
            } else {
                onCompletion(.failure(FanMakerSDKHttpError(httpCode: httpStatusCode)))
            }
        }.resume()
    }
}
