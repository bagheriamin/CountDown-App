//
//  Date.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import Foundation

extension TimeInterval {
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

// allows me to format date
extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func withAddedMinutes(minutes: Double) -> Date {
        addingTimeInterval(minutes * -60)
    }
}

//ALL AVAILABLE Format Styles
//>>-------------------------------------------------------------->
//Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//09/12/2018                        --> MM/dd/yyyy
//09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//Sep 12, 2:11 PM                   --> MMM d, h:mm a
//September 2018                    --> MMMM yyyy
//Sep 12, 2018                      --> MMM d, yyyy
//Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//12.09.18                          --> dd.MM.yy
//10:41:02.112                      --> HH:mm:ss.SSS

