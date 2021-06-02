import Foundation

public class FanMakerSDK {
    public static var apiKey : String = ""
    public static var memberID : String = ""
    public static var studentID : String = ""
    public static var ticketmasterID : String = ""
    public static var yinzid : String = ""
    
    public static func initialize(apiKey : String) {
        self.apiKey = apiKey
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
}
