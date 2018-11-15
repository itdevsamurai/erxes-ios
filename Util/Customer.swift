//
//  Customer.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 11/14/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import Apollo

class MCustomer {
    var _id:String?
    var firstName:String?
    var lastName:String?
    var avatar:String?
    var username:String?
    var email:String?
    var isUser:String?
}

public typealias EModel = Snapshot

class Cust {
    static func username(_ item:EModel) -> String {
        var username = ""
        
        if let firstname = item["firstname"] as? String,  firstname.count > 0 {
            username = firstname + " "
        }
        
        username = username + (item["lastname"] as? String ?? "")
        return username
    }
    
    static func email(_ customer:ObjectDetail.Customer) {
        
    }
    
    static func initialFromUsername() {
        
    }
}
