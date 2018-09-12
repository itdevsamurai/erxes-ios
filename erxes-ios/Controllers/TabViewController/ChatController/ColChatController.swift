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
    
    var inited = false
    
//    public typealias ModelT = TextCell.ViewModel
    var messages:[MessageDetail]! {
        didSet {
            if messages.count > 0 {
                updateView()
                if inited {
                    
                }
                inited = true
                loader.startAnimating()
            }
        }
    }
    var calculatedHeights:[CGFloat] = []
    
    var container:UIView = {
        let view = UIView()
        view.clipsToBounds = true
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
        textfield.backgroundColor = UIColor.init(hexString: "f0ebf8")
        textfield.layer.cornerRadius = 5.0
        textfield.tintColor = .ERXES_COLOR
        textfield.placeholder = "Write a reply..."
        let sendButton = UIButton(type: .custom)
        sendButton.titleLabel?.font = UIFont.fontWith(type: .ultralight, size: 14)
        //        sendButton.setTitle("Send", for: .normal)
        sendButton.setImage(UIImage.erxes(with: .send, textColor: .ERXES_COLOR), for: .normal)
        sendButton.setTitleColor(.ERXES_COLOR, for: .normal)
        sendButton.frame = CGRect(x: 0, y: CGFloat(0), width: CGFloat(60), height: CGFloat(40))
        sendButton.addTarget(self, action: #selector(btnSendClick), for: .touchUpInside)
        let line = UIView(frame: CGRect(x: 0, y: 10, width: 1, height: 20))
        line.backgroundColor = .ERXES_COLOR
        sendButton.addSubview(line)
        
        textfield.rightView = sendButton
        textfield.rightViewMode = .always
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        let attachmentButton = UIButton(type: .custom)
        attachmentButton.setImage(UIImage.erxes(with: .attach, textColor: .ERXES_COLOR), for: .normal)
        attachmentButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        attachmentButton.imageView?.contentMode = .scaleAspectFit
        attachmentButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        leftView.addSubview(attachmentButton)
        let cameraButton = UIButton(type: .custom)
        cameraButton.setImage(UIImage.erxes(with: .photocamera, textColor: .ERXES_COLOR), for: .normal)
        cameraButton.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        cameraButton.imageView?.contentMode = .scaleAspectFit
//        cameraButton.addTarget(self, action: #selector(launchCamera(sender:)), for: .touchUpInside)
        leftView.addSubview(cameraButton)
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        
        return textfield
    }()
    
    var loader: ErxesLoader = {
        let loader = ErxesLoader(frame: CGRect(x: Constants.SCREEN_WIDTH/2-25, y: Constants.SCREEN_HEIGHT/2-25, width: 50, height: 50))
        loader.lineWidth = 3
        return loader
    }()
    
    var inputContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccfd6")
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
//        self.customerId = customerId
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
        inputContainer.addSubview(chatInputView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        messages = [MessageDetail]()
        manager.delegate = self
        manager.conversationId = conversationId
        manager.queryMessages()
        manager.subscribe()
        self.container.addSubview(loader)
        self.view.backgroundColor = .white
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
        
        inputContainer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(47)
            make.bottom.equalToSuperview()
        }

        chatInputView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).inset(10)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(3)
        }

        chatView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.inputContainer.snp.top)
        }
        
        loader.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view.snp.center)
        }
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
    
    @objc func launchCamera(){
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
    
    @objc func openImagePicker(){
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
        chatInputView.text = ""
        manager.mutateAddMessage(msg: message)
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
        
        if let form = item.formWidgetData {
            height = FormCell.calculateFormHeight(item)
        } else
        if let files = item.attachments, files.count > 0 {
            height = 150
        } else {
            height = ChatBaseCell.calculateHeight(item)
        }
        
        return CGSize(width: self.view.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
