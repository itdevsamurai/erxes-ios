//
//  Date.swift
//  erxes-ios
//
//  Created by alternate on 10/16/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation


extension Date {
    var millisecondsSince1970: Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func stringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm"
        return formatter.string(from: self)
    }
    
    func mainDateString() -> String {
        //        2018-09-01
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: self)
    }
    
    
}

extension Date {
    struct Formatter {
        static let utcFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter
        }()
    }
    
    var dateToUTC: String {
        return Formatter.utcFormatter.string(from: self)
    }
    
    var hourMinutes: String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
}
