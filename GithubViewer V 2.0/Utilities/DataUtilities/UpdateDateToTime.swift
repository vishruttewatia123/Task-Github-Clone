//
//  UpdateDateToTime.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import Foundation

extension Date {
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
        
        if years(from: date) == 1 { return "last updated a year ago" }
        else if years(from: date) > 0 { return "last updated \(years(from: date)) years ago" }
        if months(from: date) == 1 { return "last updated a month ago" }
        else if months(from: date) > 0 { return "last updated \(months(from: date)) months ago" }
        if weeks(from: date) == 1 { return "last updated a week ago" }
        else if weeks(from: date) > 0 { return "last updated \(weeks(from: date)) weeks ago" }
        if days(from: date) == 1 { return "last updated a day ago" }
        else if days(from: date) > 0 { return "last updated \(days(from: date)) days ago" }
        if hours(from: date) == 1 { return "last updated a hour ago" }
        else if hours(from: date) > 0 { return "last updated \(hours(from: date)) hours ago" }
        if minutes(from: date) == 1 { return "last updated a minute ago" }
        else if minutes(from: date) > 0 { return "last updated \(minutes(from: date)) minutes ago" }
        if seconds(from: date) == 1 { return "last updated a seconds ago" }
        else if seconds(from: date) > 0 { return "last updated \(seconds(from: date)) seconds ago" }
        return ""
    }
}

class TimeChanger{
    
    let date: Date
        
    init(date: Date = Date()){
        self.date = date
    }
    
    func dateToTimeChanger(repoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: repoDate){
            return (self.date.offset(from: date)) // difference between repodate and given date, self.date is our custom date.. from: date is the date passed
        }
        return ""
    }
    
}
