//
//  DateExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 09/04/21.
//

import Foundation

/// This Date Formatter Manager help to cache already created formatter in a synchronized Dictionary to use them in future, helps in performace improvement.
class DateFormattersManager {
    public static var dateFormatters: SynchronizedDictionary = SynchronizedDictionary<String, DateFormatter>()
}

public extension Date {
    
    static let minutesInAWeek = 24 * 60 * 7
    
    /// Initializes Date from string and format. Convert String to date
    /// - Parameters:
    ///   - string: String which need to convert to date
    ///   - format: default format `yyyy-MM-dd`, but this can be overridden.
    ///   - timezone: default time zone `.autoupdatingCurrent`, but this can be overridden.
    ///   - locale: default Locale `.current`, but this can be overridden.
    init?(fromString string: String,
                 format: String = "yyyy-MM-dd",
                 timezone: TimeZone = TimeZone.autoupdatingCurrent,
                 locale: Locale = Locale.current) {
        if let dateFormatter = DateFormattersManager.dateFormatters.getValue(for: format) {
            if let date = dateFormatter.date(from: string) {
                self = date
            } else {
                return nil
            }
        } else {
            let formatter = DateFormatter()
            formatter.timeZone = timezone
            formatter.locale = locale
            formatter.dateFormat = format
            DateFormattersManager.dateFormatters.setValue(for: format, value: formatter)
            if let date = formatter.date(from: string) {
                self = date
            } else {
                return nil
            }
        }
    }
    
    /// Initializes Date from string returned from an http response, according to several RFCs / ISO. Convert String to date
    init?(httpDateString: String) {
        if let rfc1123 = Date(fromString: httpDateString, format: "EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss zzz") {
            self = rfc1123
            return
        }
        if let rfc850 = Date(fromString: httpDateString, format: "EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z") {
            self = rfc850
            return
        }
        if let asctime = Date(fromString: httpDateString, format: "EEE MMM d HH':'mm':'ss yyyy") {
            self = asctime
            return
        }
        if let iso8601DateOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd") {
            self = iso8601DateOnly
            return
        }
        if let iso8601DateHrMinOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mmxxxxx") {
            self = iso8601DateHrMinOnly
            return
        }
        if let iso8601DateHrMinSecOnly = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ssxxxxx") {
            self = iso8601DateHrMinSecOnly
            return
        }
        if let iso8601DateHrMinSecMs = Date(fromString: httpDateString, format: "yyyy-MM-dd'T'HH:mm:ss.SSSxxxxx") {
            self = iso8601DateHrMinSecMs
            return
        }
        return nil
    }
    
    /// Converts Date to String, with format
    func toString(format: String) -> String {
        
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self)
    }
    
    /// Use to get dateFormatter from synchronized Dict via dateFormatterManager
    private func getDateFormatter(for format: String) -> DateFormatter {
        
        var dateFormatter: DateFormatter?
        if let _dateFormatter = DateFormattersManager.dateFormatters.getValue(for: format) {
             dateFormatter = _dateFormatter
        } else {
            dateFormatter = createDateFormatter(for: format)
        }
        
        return dateFormatter!
    }
    
    /// CreateDateFormatter if formatter doesn't exist in Dict.
    private func createDateFormatter(for format: String) -> DateFormatter {
        let formatter        = DateFormatter()
        formatter.dateFormat = format
        formatter.locale     = Locale.autoupdatingCurrent
        formatter.calendar   = Calendar.autoupdatingCurrent
        DateFormattersManager.dateFormatters.setValue(for: format, value: formatter)
        return formatter
    }
    
    /// Calculates how many days passed from now to date
    func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/86400)
        return diff
    }
    
    /// Calculates how many hours passed from now to date
    func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/3600)
        return diff
    }
    
    /// Calculates how many minutes passed from now to date
    func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff/60)
        return diff
    }
    
    /// Calculates how many seconds passed from now to date
    func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
        diff = fabs(diff)
        return diff
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    /// Easy creation of time since date. Can be Years, Months, days, hours, minutes or seconds
    var timeAgoSinceDate:String {
        let date = Date()
        let calendar = Calendar.autoupdatingCurrent
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(components.year!) \(str) ago"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(components.month!) \(str) ago"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(components.day!) \(str) ago"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(components.hour!) \(str) ago"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(components.minute!) \(str) ago"
        } else if components.second! >= 1 {
            components.second == 1 ? (str = "second") : (str = "seconds")
            return "\(components.second!) \(str) ago"
        } else {
            return "Just now"
        }
    }
    
    /// Check if date is in future.
    var isFuture: Bool {
        return self > Date()
    }
    
    /// Check if date is in past.
    var isPast: Bool {
        return self < Date()
    }
    
    /// Check date if it is today
    var isToday: Bool {
        let format = "yyyy-MM-dd"
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self) == dateFormatter.string(from: Date())
    }
    
    /// Check date if it is yesterday
    var isYesterday: Bool {
        let format = "yyyy-MM-dd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self) == dateFormatter.string(from: yesterDay!)
    }
    
    /// Check date if it is tomorrow
    var isTomorrow: Bool {
        let format = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let dateFormatter = getDateFormatter(for: format)
        
        return dateFormatter.string(from: self) == dateFormatter.string(from: tomorrow!)
    }
    
    /// Check date if it is within this month.
    var isThisMonth: Bool {
        let today = Date()
        return self.month == today.month && self.year == today.year
    }
    
    /// Check date if it is within this week.
    var isThisWeek: Bool {
        return self.minutesInBetweenDate(Date()) <= Double(Date.minutesInAWeek)
    }
    
    /// Get the era from the date
    var era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }
    
    /// Get the year from the date
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    /// Get the month from the date
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    /// Get the week from the date
    var week: Int {
        return Calendar.current.component(Calendar.Component.weekday, from: self)
    }
    
    /// Get the weekOfMonth from the date
    var weekOfMonth: Int {
        return Calendar.current.component(Calendar.Component.weekOfMonth, from: self)
    }

    
    /// Get the day from the date
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Get the hours from date
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// Get the minute from date
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// Get the second from the date
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// Gets the nano second from the date
    var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    /// Get the weekday from the date
    var weekday: String {
        let format = "EEEE"
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self)
    }
    
    /// Get the month from the date
    var monthAsString: String {
        let format = "MMMM"
        let dateFormatter = getDateFormatter(for: format)
        return dateFormatter.string(from: self)
    }
    
    /// Create a date from specified parameters
    /// - Parameter days: Number of desired days
    /// - Returns: A `Date` object
    func changeDaysBy(days : Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = days
        return Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
    
    /// Create a date from specified parameters
    ///
    /// - Parameters:
    ///   - year: The desired year
    ///   - month: The desired month
    ///   - day: The desired day
    /// - Returns: A `Date` object
    func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
}
