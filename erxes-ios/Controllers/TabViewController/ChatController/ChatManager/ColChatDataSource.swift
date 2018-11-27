//
//  ColChatDataSource.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/8/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import Apollo
import LiveGQL

public protocol FileUploader:NSObjectProtocol {
    
}

public protocol BaseChatManager {
    func refresh()
}

class ChatManager:NSObject {
    
    let gql = LiveGQL(socket: Constants.SUBSCRITION_ENDPOINT)
    
    var conversationId:String?
    var delegate: ChatManagerDelegate?
    
    //attach properties
    var remoteUrl = ""
    var uploaded = JSON()
    var attachments = [JSON]()
    var size = 0
    var isInternal = false
    
    override init() {
        super.init()
        gql.delegate = self
    }
    
    func queryMessages() {
        if conversationId == nil {
            return
        }
        
        let messagesQuery = ConversationDetailQuery(_id: self.conversationId!)
        appnet.fetch(query: messagesQuery, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
            }
            if let allMessages = result?.data?.conversationDetail {
                self?.delegate?.onChatUpdate(allMessages)
            }
        }
    }
    
    func markAsRead(id:String) {
        let mutation = ConversationMarkAsReadMutation(id: id)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func mutateAddMessage(msg:String, isInternal:Bool, mentions:[String]) {
        let mutation = ConversationMessageAddMutation(conversationId: self.conversationId!)
        
        if msg.count > 0 {
            mutation.content = msg
        }
        
        if attachments.count > 0 {
            mutation.attachments = attachments
        }
        
        if isInternal {
            mutation.internal = isInternal
        }
        
        mutation.mentionedUserIds = mentions
        
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(result)
            self?.attachments = [JSON]()
        }
    }
}


