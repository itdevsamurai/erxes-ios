//
//  Inbox+Additions.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/18/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

extension ObjectDetail {
    func isEqual(to other: ObjectDetail) -> Bool {
        if self.id == other.id {
            
            return true
        } else {
            
            return false
        }
    }
    
    func isNew(to other: ObjectDetail) -> Bool {
        if self.content == other.content {
            
            return true
        } else {
            
            return false
        }
    }
    
    func findIndex(from: [ObjectDetail]) -> Int {
        var index: Int = 0
        
        for (i, element) in from.enumerated() {
            if self.isEqual(to: element) {
                index = i
                return i
            }
        }
        
        
        return index
    }
}

extension InboxController: FilterDelegate {
    
    func passFilterOptions(options: FilterOptions) {
        self.options = options
        self.getInbox(limit: 20)
    }
}

extension InboxController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
    }
}

extension InboxController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension InboxController: UserControllerDelegate {
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
                self?.getInbox(limit: (self?.conversationLimit)!)
            }
        }
    }
}
