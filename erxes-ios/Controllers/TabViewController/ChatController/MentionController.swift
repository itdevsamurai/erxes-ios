//
//  MentionController.swift
//  erxes-ios
//
//  Created by alternate on 10/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit
import Apollo

class MentionCell:UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 50, 0, 0))
        textLabel?.font = UIFont.fontWith(type: .comfortaa, size: 13)
    }
}

public protocol MentionControllerDelegate {
    func reload()
    func mentionUser(_ user:UserData)
}

class MentionController:NSObject {
    
    var delegate:MentionControllerDelegate?
    
    var users = [UserData]() {
        didSet{
            delegate?.reload()
//            userView.reloadData()
        }
    }
    
    var filteredUsers = [UserData]() {
        didSet {
            delegate?.reload()
        }
    }
    
    var mentionedUsers = [UserData]()
    
    var visible = false
    
    override init() {
        super.init()
        self.queryUsers()
    }
    
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
                    
                }
            }
        }
    }
    
    func filter(_ value:String) {
        if value.count > 0 {
            filteredUsers = users.filter{$0.details?.fullName?.localizedCaseInsensitiveContains(value) ?? false}
        } else {
            filteredUsers = users
        }
        for user in mentionedUsers {
            if let index = filteredUsers.index(of: user) {
                filteredUsers.remove(at: index)
            }
        }
    }
    
    func mentionedUserIds() -> [String] {
        if mentionedUsers.count > 0 {
            return mentionedUsers.map{$0.id}
        }
        return [String]()
    }
    
    func clear() {
        mentionedUsers = []
    }
}

extension MentionController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MentionCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = filteredUsers[indexPath.row].details?.fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = filteredUsers[indexPath.row]
        mentionedUsers.append(user)
        delegate?.mentionUser(user)
    }
}

extension ColChatController:MentionControllerDelegate {
    func reload() {
        userView.reloadData()
    }
    
    func mentionUser(_ user: UserData) {
        if var text = chatInputView.text, let mention = user.details?.fullName {
            var array = text.split(separator: "@", maxSplits: 10, omittingEmptySubsequences: false)
            array.remove(at: array.count - 1)
            array.append("")
            text = array.joined(separator: "@")
            chatInputView.text = text + mention + " "
            hideUserView()
        }
    }
}

extension ColChatController {
    
    func showUserView() {
        userView.isHidden = false
        mentionController.visible = true
    }
    
    func hideUserView() {
        userView.isHidden = true
        mentionController.visible = false
    }
    
    @objc func InputViewTextChanged (_ sender:UITextField) {
        
        if !isInternal { return }
        
        if mentionController.visible {
            
            guard let text = sender.text else { return }
            
            let array = text.split(separator: "@", maxSplits: 10, omittingEmptySubsequences: false)
            
            if array.count < mentionController.mentionedUsers.count + 2 {
                hideUserView()
                return
            }
            
            guard let filter = array.last?.lowercased() else { return }
            
            mentionController.filter(filter)
        } else {
            if let text = sender.text, text.last == "@" {
                showUserView()
                mentionController.filter("")
            } else {
                
            }
        }
    }
}
