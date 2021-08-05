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
    
    var dayAvailabilites: KeyValuePairs<String, Bool> {
        ["Sunday": sunAvailable, "Monday": monAvailable, "Tuesday": tueAvailable, "Wednesday": wedAvailable, "Thursday": thursAvailable, "Friday": friAvailable, "Saturday": satAvailable]
    }
    
    func foodCanBeCollected(on date: Date) -> Bool {
        dayAvailabilites[Calendar.current.component(.weekday, from: date) - 1].value
    }
    
    func nextAvailableDateFoodCanBeCollected(from date: Date) -> Date {
        var nextDate = date
        while(!foodCanBeCollected(on: nextDate)){
            nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextDate)!
        }
        return nextDate
    }
}
