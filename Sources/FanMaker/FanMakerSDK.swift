import Foundation

public class FanMakerSDK {
    public static var apiKey : String = ""
    
    public static func initialize(apiKey : String) {
        self.apiKey = apiKey
    }
    
    public static func isInitialized() -> Bool {
        return apiKey != ""
    }
}
