//
//  ChatManagerDelegate.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/9/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation

public protocol ChatManagerDelegate:NSObjectProtocol {
    func onChatUpdate(_ data: [MessageDetail])
    func onMessageRecieve(message:MessageDetail)
}

extension ChatController:ChatManagerDelegate {
    
    func onChatUpdate(_ data: [MessageDetail]) {
        messages = data
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
