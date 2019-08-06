
import Foundation
import SwiftUI

extension Date {
    
    func dateComponents() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return components
    }
    
    func dateComponentsToNotify() -> DateComponents {
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: .minute, value: -30, to: self)
        guard let date = newDate else {
            return calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        }
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
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
        if self > currentDate {
            return true
        } else {
            return false
        }
    }
    
    static func from(hour: Int, minutes: Int, year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minutes
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
    
    func dateFormatterString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
}
