//
//  ColChatController.swift
//  erxes-ios
//
//  Created by alternate on 9/4/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import SnapKit
import Photos
import LiveGQL
import Apollo
import Alamofire

class ColChatController:UIViewController {
    
    let MARGIN_RIGHT:CGFloat = 16
    let MARGIN_LEFT:CGFloat = 16
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
    
//    mention begin
    var users = [User]()
    var userView:UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        return tv
    }()
//    mention end
    
    var calculatedHeights:[CGFloat] = []
    
    var container:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    var manager:ChatManager = {
        let item = ChatManager()
        return item
    }()
    
    var chatView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
//        layout.itemSize = CGSize(width: 50, height: 50)
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
    
    var chatInputView: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor(hexString: "#f4f4f4")
        textfield.layer.cornerRadius = 18.0
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(hexString: "#d7d7d7")?.cgColor
        textfield.placeholder = "Type a message"
        let btnSend = UIButton(type: .custom)
        btnSend.frame = CGRect(x: 0, y: 0, width: 36, height: 26)
        btnSend.setImage(#imageLiteral(resourceName: "btn_send"), for: .normal)
        btnSend.contentMode = UIViewContentMode.center
        btnSend.addTarget(self, action: #selector(btnSendClick), for: .touchUpInside)
        
        textfield.rightView = btnSend
        textfield.rightViewMode = .always
        
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textfield.leftViewMode = .always
        textfield.font = UIFont.fontWith(type: .comfortaa, size: 14)
        
        return textfield
    }()
    
    var btnAttachment = UIButton()
    var btnCamera = UIButton()
    var label = UILabel()
    var btnInternalNote = UIButton()
    
    func initChatInput() {
        
        btnAttachment = UIButton(type: .custom)
        btnAttachment.setImage(UIImage.erxes(with: .attach, textColor: UIColor(hexString: "#999999")!), for: .normal)
        btnAttachment.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnAttachment.imageView?.contentMode = .scaleAspectFit
        btnAttachment.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        btnCamera = UIButton(type: .custom)
        btnCamera.setImage(UIImage.erxes(with: .photocamera, textColor: UIColor(hexString: "#999999")!), for: .normal)
        btnCamera.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        btnCamera.imageView?.contentMode = .scaleAspectFit
        btnCamera.addTarget(self, action: #selector(launchCamera), for: .touchUpInside)
        
        btnInternalNote = UIButton(type: .custom)
        btnInternalNote.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
        btnInternalNote.setImage(#imageLiteral(resourceName: "ticked"), for: .selected)
        btnAttachment.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnInternalNote.imageView?.contentMode = .scaleAspectFit
        btnInternalNote.addTarget(self, action: #selector(btnInternalNoteClick), for: .touchUpInside)
        
        label.text = "Internal note"
        label.textColor = UIColor(hexString: "#a9a9a9", alpha: 0.57)
        label.font = UIFont.fontWith(type: .comfortaa, size: 12)
        
//        btnInternalNote = UIButton(type: .custom)
//        btnInternalNote
        
        inputContainer.addSubview(chatInputView)
        inputContainer.addSubview(btnAttachment)
        inputContainer.addSubview(btnCamera)
        inputContainer.addSubview(label)
        inputContainer.addSubview(btnInternalNote)
        
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
        
        btnCamera.snp.makeConstraints{ (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnAttachment.snp.right).offset(12)
            make.height.width.equalTo(40)
        }
        
        btnInternalNote.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnCamera.snp.right).offset(12)
            make.height.width.equalTo(40)
        }

        label.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(btnInternalNote.snp.right).offset(12)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
    
    @objc func btnInternalNoteClick() {
        isInternal = !isInternal
        btnInternalNote.isSelected = isInternal
    }
    
  
    
    var inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var refresher:UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refresher
    }()
    
    convenience init(chatId:String,title:String,customerId:String){
        self.init()
        self.conversationId = chatId
        self.customerId = customerId
        self.title = title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatView.delegate = self
        self.chatView.dataSource = self
        self.view.addSubview(container)
        self.chatView.refreshControl = refresher
        container.addSubview(self.chatView)
        container.addSubview(inputContainer)
        container.addSubview(userView)
//        inputContainer.addSubview(chatInputView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        messages = [MessageDetail]()
        manager.delegate = self
        manager.conversationId = conversationId
        manager.queryMessages()
        manager.subscribe()
        manager.markAsRead(id: conversationId!)
        
        self.view.backgroundColor = .white
        
        let rightItem: UIBarButtonItem = {
           let button = UIButton()
            let barButtomItem = UIBarButtonItem()
            button.setBackgroundImage(UIImage.erxes(with: .user, textColor: .ERXES_COLOR), for: .normal)
            button.tintColor = UIColor.ERXES_COLOR
            button.addTarget(self, action: #selector(gotoUser(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        container.frame = self.view.frame
        
        container.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        chatView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(inputContainer.snp.top)
        }
        
        userView.snp.makeConstraints { (make) in
            make.bottom.equalTo(chatView.snp.bottom)
            make.right.left.equalToSuperview()
        }
        
        inputContainer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(85)
            make.bottom.equalToSuperview()
        }

//        chatInputView.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view.snp.left).offset(10)
//            make.right.equalTo(self.view.snp.right).inset(10)
//            make.height.equalTo(85)
//            make.bottom.equalToSuperview().inset(3)
//        }

        chatView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.inputContainer.snp.top)
        }
        
        
        
        initChatInput()
    }
    
    @objc func gotoUser(sender:UIButton) {
        self.navigate(.customerProfile(_id: self.customerId!))
        
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
    
    @objc func launchCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = manager
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = manager
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //        imagePicker.allowsEditing = true
        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func checkPermission() {
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    self.openImagePicker()
                } else {
                }
            })
        } else {
            self.openImagePicker()
        }
    }
}

extension ColChatController {
    
    @objc func btnSendClick() {
        guard let message = chatInputView.text, message.count > 0 else {
            return
        }
        manager.mutateAddMessage(msg: message, isInternal: isInternal)
        chatInputView.text = ""
        btnInternalNote.isSelected = false
        isInternal = false
    }
    
    @objc func btnPhotoLibraryClick() {
       checkPermission()
    }
    
    @objc func btnCameraClick() {
        
    }
}

extension ColChatController:UICollectionViewDelegate {
    
}

extension ColChatController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = messages[indexPath.row]
        var cell:ChatBaseCell
        
        if let form = item.formWidgetData {
            cell = chatView.dequeueReusableCell(withReuseIdentifier: FormCell.ID, for: indexPath) as! FormCell
        } else
        if let files = item.attachments, files.count > 0 {
            cell = chatView.dequeueReusableCell(withReuseIdentifier: ImageCell.ID, for: indexPath) as! ImageCell
        } else
        if let customerId = item.customerId {
            cell = chatView.dequeueReusableCell(withReuseIdentifier: IncomingCell.ID, for: indexPath) as! IncomingCell
        } else {
            cell = chatView.dequeueReusableCell(withReuseIdentifier: SentCell.ID, for: indexPath) as! SentCell
        }
        cell.viewModel = messages[indexPath.row]
        return cell
    }
}

extension ColChatController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = messages[indexPath.row]
        
        var height:CGFloat = 0
        
        if indexPath.row < calculatedHeights.count{
            height = calculatedHeights[indexPath.row]
        } else {
            if let form = item.formWidgetData {
                height = FormCell.calculateFormHeight(item)
            } else
                if let files = item.attachments, files.count > 0 {
                    height = 150
                } else {
                    height = ChatBaseCell.calculateHeight(item)
            }
            calculatedHeights.append(height)
        }
        
        return CGSize(width: self.view.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}
