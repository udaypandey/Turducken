import Foundation

public class FanMakerSDK {
    public static var apiKey : String = ""
    public static var memberID : String = ""
    public static var studentID : String = ""
    public static var ticketmasterID : String = ""
    public static var yinzid : String = ""
    public static var pushToken : String = ""
    public static var locationEnabled : Bool = false
    
    public static func initialize(apiKey : String) {
        self.apiKey = apiKey
        self.locationEnabled = false
    }
    
    public static func isInitialized() -> Bool {
        return apiKey != ""
    }
    
    public static func setMemberID(_ value : String) {
        self.memberID = value
    }
    
    public static func setStudentId(_ value : String) {
        self.studentID = value
    }

    public static func setTicketmasterID(_ value : String) {
        self.ticketmasterID = value
    }
    
    public static func setYinzid(_ value : String) {
        self.yinzid = value
    }
    
    public static func setPushNotificationToken(_ value : String) {
        self.pushToken = value
    }
    
    public static func enableLocationTracking() {
        self.locationEnabled = true
    }
    
    public static func disableLocationTracking() {
        self.locationEnabled = false
    }
}
