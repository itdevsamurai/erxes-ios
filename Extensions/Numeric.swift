//
//  Numeric.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation

extension Int64 {
    func dateFromUnixTime() -> Date {
        //        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let timeInterval = Double(self / 1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
}

extension Int {
    func dateFromUnixTime() -> Date {
        //        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let timeInterval = Double(self / 1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
}
