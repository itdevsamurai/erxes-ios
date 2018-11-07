//
//  ChatMenu+Network.swift
//  erxes-ios
//
//  Created by alternate on 11/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit
import Apollo

extension ChatMenu {
    
    func queryUsers() {
        let query = GetUsersQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataElseFetch) { [weak self] result, error in
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
            
            if result?.data != nil {
                if let result = result?.data?.users {
                    self?.users = result.map { ($0?.fragments.userData)! }
                    self?.filteredUsers = (self?.users)!
                }
            }
        }
    }
    
    func assignUser(user:UserData, conversationId:String) {
        let mutation = ConversationsAssignMutation(conversationIds: [conversationId])
        mutation.assignedUserId = user.id
        appnet.perform(mutation: mutation) { [weak self] result, error in
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
            if result?.data != nil {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func changeStatus(id:String, status:String) {
        let mutation = ConversationsChangeStatusMutation(_ids: [id], status: status)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                //self?.hideLoader()
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                //self?.hideLoader()
            }
            if result?.data != nil {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
