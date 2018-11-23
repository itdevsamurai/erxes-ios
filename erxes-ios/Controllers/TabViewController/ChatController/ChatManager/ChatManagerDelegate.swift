//
//  ChatManagerDelegate.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/9/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import Apollo

public protocol ChatManagerDelegate:NSObjectProtocol {
    func onChatUpdate(_ data: ConversationDetailQuery.Data.ConversationDetail)
    func onMessageRecieve(message:MessageDetail)
}

extension ChatController:ChatManagerDelegate {
    
    func onChatUpdate(_ data: ConversationDetailQuery.Data.ConversationDetail) {
        messages = (data.messages?.map {($0?.fragments.messageDetail)!})!
        brand = data.integration?.brand?.snapshot
        customer = data.customer?.snapshot
        updateView()
        refresher.endRefreshing()
    }
    
    func onMessageRecieve(message:MessageDetail) {
        messages.append(message)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.scrollToBottom()
        }
    }
}
