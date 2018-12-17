//
//  LiveGQL.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/9/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import LiveGQL

extension ChatManager: LiveGQLDelegate {
    
    func subscribe() {
        gql.subscribe(graphql: "subscription{conversationMessageInserted(_id:\"\(self.conversationId!)\"){_id,content,userId,createdAt,customerId,internal,user{_id,details{avatar}},attachments{url,type,name,size}}}", variables: nil, operationName: nil, identifier: "conversationMessageInserted")
    }
    
    public func receivedRawMessage(text: String) {
        do {
//            print(text)
            if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
                
                let result = try JSONDecoder().decode(MessageSubs.self, from: dataFromString)
                
                guard let item = result.payload?.data?.conversationMessageInserted else {
                    return
                }
                
                print("subs: " + item._id)
                
                
                if lastId == item._id {
                    return
                }
                lastId = item._id
                
                var message = MessageDetail(id:(item._id)!, content:item.content, userId:item.userId, createdAt: item.createdAt)
                
                if let details = item.user?.details {
                    let user = MessageDetail.User(id: (item.user?._id)!, details: MessageDetail.User.Detail(avatar: details.avatar))
                    message.user = user
                }
                
                if item.attachments.count > 0, let attachment = item.attachments.first {
                    
                    if let url = attachment?.url, let type = attachment?.type {
                        var attachments = [MessageDetail.Attachment]()
                        let file = MessageDetail.Attachment.init(url: url, name: "", size: 0, type: type)
                        attachments.append(file)
                        message.attachments = attachments
                    }
                }
                
                message.internal = item.internal
                
                delegate?.onMessageRecieve(message: message)
            }
        }
        catch {
            print(error)
        }
    }
}
