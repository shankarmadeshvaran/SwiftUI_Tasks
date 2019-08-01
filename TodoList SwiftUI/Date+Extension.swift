
import SwiftUI

extension Date {
    
    func dateComponents() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components
    }
    
    func isEqual(currentDate: Date) -> Bool {
        if self.dateComponents().day == currentDate.dateComponents().day {
            return true
        } else {
            return false
        }
    }
    
    func isPast(today currentDate: Date) -> Bool {
        if let givenDate = currentDate.dateComponents().day ,
            self.dateComponents().day != nil {
            if givenDate > self.dateComponents().day! {
                return false
            } else if givenDate < self.dateComponents().day! {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
