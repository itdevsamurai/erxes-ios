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
        gql.subscribe(graphql: "subscription{conversationMessageInserted(_id:\"\(self.conversationId!)\"){_id,content,userId,createdAt,customerId,internal,user{_id,details{avatar}},attachments}}", variables: nil, operationName: nil, identifier: "conversationMessageInserted")
    }
    
    public func receivedRawMessage(text: String) {
        do{
            print(text)
            if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
                
                let result = try JSONDecoder().decode(MessageSubs.self, from: dataFromString)
                
                guard let item = result.payload?.data?.conversationMessageInserted else {
                    return
                }
                
                var message = MessageDetail(id:(item._id)!, content:item.content, userId:item.userId, createdAt: item.createdAt)
                
                if let details = item.user?.details {
                    let user = MessageDetail.User(id: (item.user?._id)!, details: MessageDetail.User.Detail(avatar: details.avatar))
                    message.user = user
                }
                
                if item.attachments.count > 0, let attachment = item.attachments.first {
                    var attachments = [JSON]()
                    var file = JSON()
                    file["url"] = attachment?.url
                    file["type"] = attachment?.type
                    file["size"] = attachment?.size
                    attachments.append(file)
                    message.attachments = attachments
                }
                
                message.internal = item.internal
                
                delegate?.onMessageRecieve(message: message)
            }
        }
        catch{
            print(error)
        }
    }
}
