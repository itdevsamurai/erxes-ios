//
//  ChatControllerUI.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/8/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

class ChatControllerUI:ViewController {
    
    let MARGIN_RIGHT:CGFloat = 16
    let MARGIN_LEFT:CGFloat = 16
    let btnAttachment = UIButton(type: .custom)
    let btnCamera = UIButton(type: .custom)
    let label = UILabel()
    let btnInternalNote = UIButton(type: .custom)
    let btnTemplate = UIButton(type: .custom)
    
    let container:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let userView:UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.separatorColor = .lightGray
        tv.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0)
        return tv
    }()
    
    let chatView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let view = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        view.register(SentCell.self, forCellWithReuseIdentifier: SentCell.ID)
        view.register(IncomingCell.self, forCellWithReuseIdentifier: IncomingCell.ID)
        view.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.ID)
        view.register(FormCell.self, forCellWithReuseIdentifier: FormCell.ID)
        view.backgroundColor = .white
        return view
    }()
    
    let btnSend:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 36, height: 26)
        btn.setImage(#imageLiteral(resourceName: "btn_send"), for: .normal)
        btn.contentMode = UIViewContentMode.center
        return btn
    }()
    
    let chatInputView: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor(hexString: "#f4f4f4")
        textfield.layer.cornerRadius = 18.0
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(hexString: "#d7d7d7")?.cgColor
        textfield.placeholder = "Type a message"
        textfield.keyboardType = .emailAddress
        
//        btnSend.addTarget(self, action: #selector(btnSendClick), for: .touchUpInside)
        textfield.rightViewMode = .always
        
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textfield.leftViewMode = .always
        textfield.font = Font.regular(14)
//        textfield.addTarget(self, action: #selector(InputViewTextChanged(_:)), for: .editingChanged)
        
        return textfield
    }()
    
    let inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var refresher:UIRefreshControl = {
        let refresher = UIRefreshControl()
//        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refresher
    }()
    
    override func prepareView() {
        
        self.view.addSubview(container)
        self.chatView.refreshControl = refresher
        container.addSubview(self.chatView)
        container.addSubview(inputContainer)
        container.addSubview(userView)
        chatInputView.rightView = btnSend
        //        inputContainer.addSubview(chatInputView)
        
        self.view.backgroundColor = .white
        
        let rightItem: UIBarButtonItem = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            let barButtomItem = UIBarButtonItem()
            button.setBackgroundImage(UIImage.erxes(with: .target1, textColor: .white), for: .normal)
            button.tintColor = .white
//            button.addTarget(self, action: #selector(gotoUser(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func layoutView() {
        
        container.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        chatView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(inputContainer.snp.top)
        }
        
        inputContainer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(85)
            make.bottom.equalToSuperview()
        }
        
        chatView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.inputContainer.snp.top)
        }
    }
    
    func initChatInput() {
        prepareChatInput()
        layoutChatInput()
    }
    
    func prepareChatInput() {
        btnAttachment.setImage(UIImage.erxes(with: .attach, textColor: UIColor(hexString: "#999999")!), for: .normal)
        btnAttachment.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnAttachment.imageView?.contentMode = .scaleAspectFit
        //        btnAttachment.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)

        btnCamera.setImage(UIImage.erxes(with: .photocamera, textColor: UIColor(hexString: "#999999")!), for: .normal)
        btnCamera.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        btnCamera.imageView?.contentMode = .scaleAspectFit
        //        btnCamera.addTarget(self, action: #selector(launchCamera), for: .touchUpInside)

        btnInternalNote.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
        btnInternalNote.setImage(#imageLiteral(resourceName: "ticked"), for: .selected)
        btnAttachment.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnInternalNote.imageView?.contentMode = .scaleAspectFit
        //        btnInternalNote.addTarget(self, action: #selector(btnInternalNoteClick), for: .touchUpInside)
        
        label.text = "Internal note"
        label.textColor = UIColor(hexString: "#a9a9a9", alpha: 0.57)
        label.font = Font.regular(12)
        
        
        btnTemplate.setImage(UIImage.erxes(with: .upload2, textColor: UIColor(hexString: "#999999")!), for: .normal)
        btnTemplate.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        btnTemplate.imageView?.contentMode = .scaleAspectFit
        
        inputContainer.addSubview(chatInputView)
        inputContainer.addSubview(btnAttachment)
        inputContainer.addSubview(btnCamera)
        inputContainer.addSubview(label)
        inputContainer.addSubview(btnInternalNote)
        inputContainer.addSubview(btnTemplate)
    }
    
    func layoutChatInput() {
        chatInputView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.right.equalToSuperview().offset(-23)
            make.left.equalToSuperview().offset(23)
            make.height.equalTo(36)
        }
        
        btnAttachment.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.height.width.equalTo(40)
        }
        
        btnCamera.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnAttachment.snp.right).offset(12)
            make.height.width.equalTo(40)
        }
        
        btnTemplate.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnCamera.snp.right).offset(12)
            make.height.width.equalTo(40)
        }
        
        btnInternalNote.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnTemplate.snp.right).offset(12)
            make.height.width.equalTo(40)
        }
        
        label.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnInternalNote.snp.right).offset(12)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
    
}
