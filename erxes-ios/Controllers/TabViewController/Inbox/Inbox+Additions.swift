//
//  Inbox+Additions.swift
//  erxes-ios
//
//  Created by alternate on 9/18/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit
import LiveGQL


extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    struct Formatter {
        static let utcFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E MMM dd yyyy HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter
        }()
    }
    
    var dateFromUTC: Date? {
        let endIndex = self.index(self.endIndex, offsetBy: -15)
        
        return Formatter.utcFormatter.date(from: self.substring(to: endIndex))
        
    }
    
    
}

extension Int64 {
    func dateFromUnixTime() -> Date {
        //        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let timeInterval = Double(self / 1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
}

extension Int {
    func dateFromUnixTime() -> Date {
        //        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let timeInterval = Double(self / 1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
}

extension Date {
    struct Formatter {
        static let utcFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter
        }()
    }
    
    var dateToUTC: String {
        return Formatter.utcFormatter.string(from: self)
    }
    
    var hourMinutes: String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
}


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

extension InboxController: LiveGQLDelegate {
    
    public func receivedRawMessage(text: String) {
        do {
            
            if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
                
                let item = try JSONDecoder().decode(ConvSubs.self, from: dataFromString)
                //                self.getInbox(limit: self.conversationLimit)
                let result = item.payload?.data?.conversationsChanged
                
                
                switch result?.type {
                    
                case "newMessage":
                    self.getLast()
                    
                case "open":
                    print("open")
                case "closed":
                    print("close")
                case "assigneeChanged":
                    print("changed")
                default:
                    print("default")
                }
                self.getUnreadCount()
                
            }
        }
        catch {
            print(error)
        }
    }
}

extension InboxController: FilterDelegate {
    func passFilterOptions(options: FilterOptions) {
        self.options = options
        self.filterListView.removeAllTags()
        if options.brand != nil {
            let tagView = TagView(title: (options.brand?.name)!)
            
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            
            tagView.tag = 101
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        if options.channel != nil {
            let tagView = TagView(title: (options.channel?.name)!)
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 102
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
            //            self.filterListView.addTag((options.channel?.name)!)
        }
        if options.tag != nil {
            let tagView = TagView(title: (options.tag?.name)!)
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 103
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        
        if options.startDate.count != 0 && options.endDate.count != 0 {
            let tagView = TagView(title: options.startDate + " - " + options.endDate)
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 104
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        if options.status.count != 0 {
            let tagView = TagView(title: options.status)
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 105
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        if options.participating.count != 0 {
            let tagView = TagView(title: "Participating")
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 106
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        if options.unassigned.count != 0 {
            
            let tagView = TagView(title: "Unassigned")
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 107
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        if options.integrationType.count != 0 {
            let tagView = TagView(title: options.integrationType)
            tagView.cornerRadius = 6
            tagView.enableRemoveButton = true
            tagView.removeIconLineColor = .white
            tagView.removeIconLineWidth = 0.7
            tagView.tag = 108
            tagView.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            //
            tagView.backgroundColor = UIColor.ERXES_COLOR
            tagView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
            tagView.clipsToBounds = false
            self.filterListView.addTagView(tagView)
        }
        self.getInbox(limit: 10)
    }
    
    @objc func removeTag(sender: TagView) {
        self.filterListView.removeTagView(sender)
        switch sender.tag {
        case 101:
            self.options?.brand = nil
        case 102:
            self.options?.channel = nil
        case 103:
            self.options?.tag = nil
        case 104:
            self.options?.startDate = ""
            self.options?.endDate = ""
        case 105:
            self.options?.status = ""
        case 106:
            self.options?.participating = ""
        case 107:
            self.options?.unassigned = ""
        case 108:
            self.options?.integrationType = ""
        default:
            print("")
        }
        self.getInbox(limit: 10)
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
    func assignUser(userId:String, conversationId:String){
        let mutation = ConversationsAssignMutation(conversationIds: [conversationId])
        mutation.assignedUserId = userId
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
