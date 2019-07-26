//
//  ColChatController.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/4/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
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
    var customer:EModel!
    var customerAvatar:UIImage?
    var inited = false
    var isInternal = false
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
    
    var brand:EModel!
    
    let templateController = TemplateController()
    
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
    
    convenience init(chatId:String, title:String) {
        self.init()
        self.conversationId = chatId
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler),
                                               name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler),
                                               name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        
        templateController.delegate = self
        
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: menu)
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuRightNavigationController?.sideMenuDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initChatInput()
        btnSend.addTarget(self, action: #selector(btnSendClick), for: .touchUpInside)
        chatInputView.addTarget(self, action: #selector(inputViewTextChanged(_:)), for: .editingChanged)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        //        button.addTarget(self, action: #selector(gotoUser(sender:)), for: .touchUpInside)
        btnAttachment.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        btnCamera.addTarget(self, action: #selector(btnCameraClick), for: .touchUpInside)
        btnInternalNote.addTarget(self, action: #selector(btnInternalNoteClick), for: .touchUpInside)
        btnTemplate.addTarget(self, action: #selector(showTemplates), for: .touchUpInside)
        if let btn = self.navigationItem.rightBarButtonItem?.customView as? UIButton {
            btn.addTarget(self, action: #selector(gotoUser(sender:)), for: .touchUpInside)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        showTemplates()
    }
    
    @objc func gotoUser(sender:UIButton) {
        menu.conversationId = conversationId!
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }
    
    @objc func showTemplates() {
//        templateController.delegate = self
//        if self.options != nil {
//            filterController.filterOptions = self.options!
//        }
        templateController.modalPresentationStyle = .overFullScreen
        templateController.brand = brand
        self.present(templateController, animated: true) {}
    }
    
    func updateView() {
        chatView.reloadData()
    }
    
    func scrollToBottom() {
        
        if (self.chatView.numberOfSections == 0) {
            return
        }
        
        //working but slow
        let items = self.chatView.numberOfItems(inSection: 0)
        if (items > 0) {
            self.chatView.layoutIfNeeded()
            let scrollRect = CGRect(x: 0, y: self.chatView.contentSize.height - 1, width: 1.0, height: 1.0)
            self.chatView.scrollRectToVisible(scrollRect, animated: true)
        }
    }
    
    @objc func refresh() {
        self.manager.queryMessages()
    }

}

extension ChatController:UISideMenuNavigationControllerDelegate {
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        if pushProfile {
            pushProfile = false
            self.navigate(.customerProfile(_id: self.customerId))
        }
    }
}
