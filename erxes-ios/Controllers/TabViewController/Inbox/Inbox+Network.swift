//
//  Inbox+Network.swift
//  erxes-ios
//
//  Created by alternate on 11/15/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit
import Apollo

extension InboxController {
    @objc func getInbox(limit: Int = 20) {
        
        if loading {
            return
        }
        loading = true
        getUnreadCount()
        
        if self.timer != nil {
            self.timer.invalidate()
        }
        let query = ObjectsQuery()
        
        if options != nil {
            query.brandId = options?.brand?.id
            if options?.unassigned.count != 0 {
                query.unassigned = "true"
            }
            if options?.participating.count != 0 {
                query.participating = "true"
            }
            query.channelId = options?.channel?.id
            query.status = options?.status
            query.integrationType = options?.integrationType
            if options?.startDate.count != 0 {
                query.startDate = (options?.startDate)! + " 00:00"
            }
            
            if options?.endDate.count != 0 {
                query.endDate = (options?.endDate)! + " 00:00"
            }
            query.tag = options?.tag?.id
            
        }
        query.limit = limit
        
        appnet.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData) { [weak self] result, error in
            
            self?.refresher.endRefreshing()
            if !(self?.loading)! {
                return
            }
            self?.loading = false
            
            if let error = error {
                
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
            }
            if result?.data != nil {
                if let allConversations = result?.data?.conversations {
                    
                    if allConversations.count < self?.conversationLimit ?? 0 {
                        self?.lastPage = true
                    }
                    
                    if allConversations.count == 0 {
                        self?.conversations.removeAll()
                        self?.tableView.reloadData()
                        self?.tableView.isHidden = true
                        self?.robotView.isHidden = false
                    } else {
                        self?.tableView.isHidden = false
                        self?.robotView.isHidden = true
                        self?.conversations = allConversations.map { ($0?.fragments.objectDetail)! }
                    }
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func getUnreadCount() {
        let query = UnreadCountQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
            }
            if result?.data != nil {
                if let count = result?.data?.conversationsTotalUnreadCount {
                    
                    if count != 0 {
                        self?.tabBarItem.badgeColor = .red
                        self?.tabBarItem.badgeValue = String(format: "%i", count)
                    } else {
                        self?.tabBarItem.badgeValue = nil
                    }
                }
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
                self?.getInbox(limit: (self?.conversationLimit)!)
            }
        }
    }
}
