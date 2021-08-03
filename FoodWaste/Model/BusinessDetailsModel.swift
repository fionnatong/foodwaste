import Foundation
import UIKit

struct BusinesssDetailsModel: Codable, Identifiable {
    var id: String = UUID().uuidString
    var bizName: String = ""
    var uenNum: String = ""
    var bizAdd: String = ""
    var postalCode: String = ""
    
    var monAvailable: Bool = false
    var tueAvailable: Bool = false
    var wedAvailable: Bool = false
    var thursAvailable: Bool = false
    var friAvailable: Bool = false
    var satAvailable: Bool = false
    var sunAvailable: Bool = false
    
    var typesOfItemsSold = Set<String>()
    var startTime = Date(timeIntervalSince1970: 1596412800)
    var endTime = Date(timeIntervalSince1970: 1596448800)
}
