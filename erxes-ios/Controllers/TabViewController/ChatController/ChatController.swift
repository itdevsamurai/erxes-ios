//
//  ColChatController.swift
//  erxes-ios
//
//  Created by alternate on 9/4/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import SnapKit
import LiveGQL
import Apollo
import Alamofire
import SideMenu

class ChatController:ChatControllerUI {
    
    var conversationId:String?
    var customerId:String?
    var inited = false
    var isInternal = false
//    public typealias ModelT = TextCell.ViewModel
    var messages:[MessageDetail]! {
        didSet {
            if messages.count > 0 {
                updateView()
                if inited {
                    
                }
                inited = true
            }
        }
    }
    
    var mentionController = MentionController()
    
    var calculatedHeights:[CGFloat] = []
    
    var manager:ChatManager = {
        let item = ChatManager()
        return item
    }()

    var menu:ChatMenu = {
        let vc = ChatMenu()
        return vc
    }()
    
    convenience init(chatId:String,title:String,customerId:String) {
        self.init()
        self.conversationId = chatId
        self.customerId = customerId
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        messages = [MessageDetail]()
        manager.delegate = self
        manager.conversationId = conversationId
        manager.queryMessages()
        manager.subscribe()
        manager.markAsRead(id: conversationId!)
        
        userView.delegate = mentionController
        userView.dataSource = mentionController
        mentionController.delegate = self
        
        chatView.delegate = self
        chatView.dataSource = self
        
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: menu)
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initChatInput()
        btnSend.addTarget(self, action: #selector(btnSendClick), for: .touchUpInside)
        chatInputView.addTarget(self, action: #selector(InputViewTextChanged(_:)), for: .editingChanged)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        //        button.addTarget(self, action: #selector(gotoUser(sender:)), for: .touchUpInside)
        btnAttachment.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        btnCamera.addTarget(self, action: #selector(btnCameraClick), for: .touchUpInside)
        btnInternalNote.addTarget(self, action: #selector(btnInternalNoteClick), for: .touchUpInside)
        if let btn = self.navigationItem.rightBarButtonItem?.customView as? UIButton {
            btn.addTarget(self, action: #selector(gotoUser(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func gotoUser(sender:UIButton) {
        
        menu.conversationId = conversationId!
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        
    }
    
    func updateView() {
        chatView.reloadData()
//        chatView.performBatchUpdates(nil, completion: {
//            (result) in
//            self.scrollToBottom()
//        })
//        chatView.collectionViewLayout.invalidateLayout()
//        scrollToBottom()
    }
    
    func scrollToBottom(){
        
        if (self.chatView.numberOfSections == 0) {
            return;
        }
        
        //working but slow
        let items = self.chatView.numberOfItems(inSection: 0);
        if (items > 0) {
            self.chatView.layoutIfNeeded();
            let scrollRect = CGRect(x: 0, y: self.chatView.contentSize.height - 1, width: 1.0, height: 1.0)
            self.chatView.scrollRectToVisible(scrollRect, animated: true)
        }
        
        //TODO: correct this
//        self.chatView.setContentOffset(self.chatView.contentOffset, animated: false)
//
//        // Note that we don't rely on collectionView's contentSize. This is because it won't be valid after performBatchUpdates or reloadData
//        // After reload data, collectionViewLayout.collectionViewContentSize won't be even valid, so you may want to refresh the layout manually
//        let offsetY = max(-self.chatView.contentInset.top, self.chatView.collectionViewLayout.collectionViewContentSize.height - self.chatView.bounds.height + self.chatView.contentInset.bottom)
//
//        // Don't use setContentOffset(:animated). If animated, contentOffset property will be updated along with the animation for each frame update
//        // If a message is inserted while scrolling is happening (as in very fast typing), we want to take the "final" content offset (not the "real time" one) to check if we should scroll to bottom again
//
//        self.chatView.contentOffset = CGPoint(x: 0, y: offsetY)
    }
    
    @objc func refresh() {
        self.manager.queryMessages()
    }

}
