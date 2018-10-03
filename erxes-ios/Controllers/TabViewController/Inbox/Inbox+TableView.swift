//
//  Inbox+TableView.swift
//  erxes-ios
//
//  Created by alternate on 9/18/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

extension InboxController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if conversations.count != 0 {
            return conversations.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ErxesInboxCell", for: indexPath) as? ErxesInboxCell
        if cell == nil {
            cell = ErxesInboxCell.init(style: .default, reuseIdentifier: "ErxesInboxCell")
        }
        if conversations.count != 0 {
            cell?.clearColor()
            let conversation = conversations[indexPath.row]
            
            cell?.avatar.image = nil
            cell?.fullName.text = ""
            cell?.desc.text = ""
            cell?.message.text = ""
            cell?.date.text = ""
            cell?.userAvatar.image = nil
            var userName = ""
            if conversation.customer?.firstName != nil && conversation.customer?.lastName != nil {
                userName = String(format: "%@ %@", (conversation.customer?.firstName)!, (conversation.customer?.lastName)!)
                if userName.count > 1 {
                    if (conversation.customer?.isUser != nil) {
                        if (conversation.customer?.isUser)! {
                            cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor(red: 96 / 255, green: 210 / 255, blue: 214 / 255, alpha: 1.0), attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                        } else {
                            cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor.ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                        }
                    } else {
                        cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor.ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                    }
                } else {
                    if conversation.customer?.email != nil {
                        if conversation.customer?.email?.count != 0 {
                            userName = (conversation.customer?.email!)!
                        } else {
                            userName = "Unnamed"
                        }
                    } else {
                        userName = "Unnamed"
                    }
                    
                    cell?.avatar.image = #imageLiteral(resourceName: "ic_avatar")
                }
            } else if conversation.customer?.firstName == nil && conversation.customer?.lastName == nil {
                if conversation.customer?.email != nil {
                    if conversation.customer?.email?.count != 0 {
                        userName = (conversation.customer?.email!)!
                    } else {
                        userName = "Unnamed"
                    }
                } else {
                    userName = "Unnamed"
                }
                cell?.avatar.image = #imageLiteral(resourceName: "ic_avatar")
            } else if conversation.customer?.firstName?.count == 0 && conversation.customer?.lastName?.count == 0 {
                if conversation.customer?.email != nil {
                    if conversation.customer?.email?.count != 0 {
                        userName = (conversation.customer?.email!)!
                    } else {
                        userName = "Unnamed"
                    }
                } else {
                    userName = "Unnamed"
                }
                
                cell?.avatar.image = #imageLiteral(resourceName: "ic_avatar")
            } else if conversation.customer?.firstName != nil {
                userName = (conversation.customer?.firstName!)!
                if (conversation.customer?.isUser != nil) {
                    if (conversation.customer?.isUser)! {
                        cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor(red: 96 / 255, green: 210 / 255, blue: 214 / 255, alpha: 1.0), attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                    } else {
                        cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor.ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                    }
                } else {
                    cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor.ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                }
            } else if conversation.customer?.lastName != nil {
                userName = (conversation.customer?.lastName!)!
                if (conversation.customer?.isUser != nil) {
                    if (conversation.customer?.isUser)! {
                        cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor(red: 96 / 255, green: 210 / 255, blue: 214 / 255, alpha: 1.0), attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                    } else {
                        cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor.ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                    }
                } else {
                    cell?.avatar.setImageWithString(text: userName, backGroundColor: UIColor.ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
                }
            }
            
            
            cell?.fullName.text = userName
            
            var desc = ""
            
            if let brandName = conversation.integration?.brand?.name {
                desc += "to \(brandName)"
            }
            
            if let integrationKind = conversation.integration?.kind {
                desc += " via \(integrationKind)"
            }
            
            cell?.desc.text = desc
            
            if conversation.readUserIds?.count == 0 {
                cell?.message.textColor = .black
            } else {
                cell?.message.textColor = UIColor(hexString: "#232323", alpha:0.5)
            }
            cell?.message.text = conversation.content?.html2String
            
            let date = conversation.updatedAt?.dateFromUnixTime()
            
            let now = Date()
            
            let dateLblValue = self.getTimeComponentString(olderDate: date!, newerDate: now)
            
            cell?.date.text = dateLblValue
            cell?.tagListView.removeAllTags()
            
            if conversation.tags?.count != 0 {
                for tag in conversation.tags! {
                    cell?.tagListView.addTag((tag?.name)!)
                }
            }
            
            if conversation.integration?.kind != nil && conversation.integration?.kind == "facebook" {
                if conversation.facebookData?.kind != nil && conversation.facebookData?.kind == "messenger" {
                    cell?.setIcon(type: .messenger)
                } else if conversation.facebookData?.kind == "feed" {
                    cell?.setIcon(type: .feed)
                }
            } else if conversation.integration?.kind != nil && conversation.integration?.kind == "messenger" {
                if (conversation.customer?.isUser)! && conversation.customer?.isUser != nil  {
                    cell?.setIcon(type: .user)
                } else {
                    cell?.setIcon(type: .notuser)
                }
            } else if conversation.integration?.kind != nil && conversation.integration?.kind == "form" {
                cell?.setIcon(type: .form)
            } else if conversation.integration?.kind != nil && conversation.integration?.kind == "twitter" {
                cell?.setIcon(type: .twitter)
            }
            
            if conversation.assignedUser != nil && conversation.assignedUser?.details?.avatar != nil {
                cell?.userAvatar.sd_setImage(with: URL(string: (conversation.assignedUser?.details?.avatar)!), placeholderImage: UIImage(named: "avatar.png"))
                
            }
        }
        
        return cell!
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        //        self.timer.invalidate()
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 0.0 {
//            conversationLimit = conversationLimit + 10
//            self.getInbox(limit: conversationLimit)
//            //             self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(inboxTimer(sender:)), userInfo: self.conversationLimit, repeats: true)
//        }
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let conversation = self.conversations[indexPath.row]
        let currentCell = tableView.cellForRow(at: indexPath) as! ErxesInboxCell
        
        var arr = [UITableViewRowAction]()
        let assignAction = UITableViewRowAction(style: .normal, title: "Assign") { (rowAction, indexPath) in
            let controller = UsersController()
            controller.delegate = self
            controller.conversationId = conversation.id
            self.presentViewControllerAsPopover(viewController: controller, from: currentCell.userAvatar)
        }
        assignAction.backgroundColor = UIColor.ERXES_COLOR
        arr.append(assignAction)
        
        
        if conversation.status == "closed" {
            let openAction = UITableViewRowAction(style: .normal, title: "Open") { (rowAction, indexPath) in
                self.changeStatus(id: conversation.id, status: "open")
            }
            openAction.backgroundColor = UIColor.init(hexString: "f8d05e")
            arr.append(openAction)
        } else {
            let closeAction = UITableViewRowAction(style: .normal, title: "Resolve") { (rowAction, indexPath) in
                //TODO: edit the row at indexPath here
                self.changeStatus(id: conversation.id, status: "closed")
            }
            closeAction.backgroundColor = UIColor.init(hexString: "37ce49")
            arr.append(closeAction)
        }
        
        
        
        return arr
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        if let brand = conversation.integration?.brand {
            navigate(.chat(withId: conversation.id, title: brand.name!, customerId: (conversation.customer?.id)!))
        } else {
            navigate(.chat(withId: conversation.id, title: (conversation.integration?.kind)!, customerId: (conversation.customer?.id)!))
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
//        let shadovFrame = shadovView.frame
//        if scrollView.contentOffset.y < 0 {
//
//            UIView.animate(withDuration: 0.3) {
//
//                self.shadovView.frame = CGRect(x: shadovFrame.origin.x, y: self.topOffset + 75, width: shadovFrame.size.width, height: shadovFrame.size.height)
//                self.tableView.frame = CGRect(x: shadovFrame.origin.x, y: self.topOffset + 75, width: shadovFrame.size.width, height: shadovFrame.size.height)
//
//            }
//        } else {
//
//            UIView.animate(withDuration: 0.3) {
//
//                self.shadovView.frame = CGRect(x: 16, y: self.topOffset, width: shadovFrame.size.width, height: shadovFrame.size.height)
//                self.tableView.frame = CGRect(x: 16, y: self.topOffset, width: shadovFrame.size.width, height: shadovFrame.size.height)
//            }
//        }
    }
    
    
}
