//
//  Inbox+LiveGQL.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import LiveGQL

extension InboxController: LiveGQLDelegate {
    
    public func receivedRawMessage(text: String) {
        
        print(text)
        
        do {
            
            if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
                
                let item = try JSONDecoder().decode(ConvSubs.self, from: dataFromString)
                //                self.getInbox(limit: self.conversationLimit)
                let result = item.payload?.data?.conversationClientMessageInserted
                
                
//                switch result?.type {
//
//                case "newMessage":
//                    self.getLast()
//
//                case "open":
//                    print("open")
//                case "closed":
//                    print("close")
//                case "assigneeChanged":
//                    print("changed")
//                default:
//                    print("default")
//                }
                refresh()
                self.getUnreadCount()
                
            }
        }
        catch {
            print(error)
        }
    }
}
