//
//  ResponseModel.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/19/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

struct MyData: Codable {
    var _id:String!
    var conversationId:String?

}

struct ConvSubsData: Codable{
    var conversationClientMessageInserted:MyData?
}

struct ConvSubsPayload:Codable{
    var data:ConvSubsData?
}

struct ConvSubs:Codable{
    var payload:ConvSubsPayload?
}

enum ResultType {
    case newMessage
    case open
    case closed
    case assigneeChanged
}
