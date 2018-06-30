//
//  ChatController.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/7/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import LiveGQL
import WebKit
import SnapKit
import Apollo
import AVFoundation
//import KCKeyboardImagePicker
import Alamofire
import Photos
import MobileCoreServices

class ChatController: UIViewController {

    var player: AVAudioPlayer?
    var isPickerActive = false
    var loader: ErxesLoader = {
        let loader = ErxesLoader()
        loader.lineWidth = 3
        return loader
    }()
    var selectedImageIndex = Int()
    var pickerIsShown:Bool = false
    var currentInputView: UIView?
    var uploadUrl = "" {
        didSet{
            sendMessage(UIButton())
        }
    }
    var uploaded = JSON()
    var pickerContainer = UIView()
    var attachments = [JSON]()
    var imagePicker = ImagePickerController()
    var keyboardFrame = CGRect(){
        didSet{
            

            moveTextField()
           print(keyboardFrame)
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "facebook_messagetone", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
           
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    let client: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let currentUser = ErxesUser.sharedUserInfo()
        configuration.httpAdditionalHeaders = ["x-token": currentUser.token as Any,
                                               "x-refresh-token": currentUser.refreshToken as Any]
        let url = URL(string: Constants.API_ENDPOINT + "/graphql")!
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
//    ws://\(host):3300/subscriptions
    
    let gql = LiveGQL(socket: Constants.SUBSCRITION_ENDPOINT)
    
    func configLive(){
        gql.delegate = self
    }
    
    func subscribe(){
        gql.subscribe(graphql: "subscription{conversationMessageInserted(_id:\"\(self.conversationId!)\"){content,userId,createdAt,customerId,user{details{avatar}},attachments}}", variables: nil, operationName: nil, identifier: "conversationMessageInserted")
    }
    
    var conversationId:String?
    var inited = false
    var bg = "#5629b6"
    var css = ""
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccfd6")
//         view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    var inputContainer:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "cccfd6")
//        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    var chatInputView: UITextField = {
       let textfield = UITextField()
        textfield.backgroundColor = UIColor.init(hexString: "f0ebf8")
        textfield.layer.cornerRadius = 5.0
        textfield.tintColor = Constants.ERXES_COLOR!
        textfield.placeholder = "Write a reply..."
        let sendButton = UIButton(type: .custom)
        sendButton.titleLabel?.font = Constants.ULTRALIGHT
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(Constants.ERXES_COLOR!, for: .normal)
        sendButton.frame = CGRect(x: 0, y: CGFloat(0), width: CGFloat(60), height: CGFloat(40))
        sendButton.addTarget(self, action: #selector(sendMessage(_:)), for: .touchUpInside)
        let line = UIView(frame: CGRect(x: 0, y: 10, width: 1, height: 20))
        line.backgroundColor = Constants.ERXES_COLOR!
        sendButton.addSubview(line)
        
        textfield.rightView = sendButton
        textfield.rightViewMode = .always
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        let attachmentButton = UIButton(type: .custom)
        attachmentButton.setImage(#imageLiteral(resourceName: "ic_attachment"), for: .normal)
        attachmentButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        attachmentButton.imageView?.contentMode = .scaleAspectFit
        attachmentButton.addTarget(self, action: #selector(openImagePicker(sender:)), for: .touchUpInside)
        leftView.addSubview(attachmentButton)
        let cameraButton = UIButton(type: .custom)
        cameraButton.setImage(#imageLiteral(resourceName: "ic_camera"), for: .normal)
        cameraButton.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        cameraButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.addTarget(self, action: #selector(launchCamera(sender:)), for: .touchUpInside)
        leftView.addSubview(cameraButton)
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        
        return textfield
    }()
    
    @objc func launchCamera(sender:UIButton){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = self
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
    
    @objc func openImagePicker(sender:UIButton){
       
        if !pickerIsShown{
            self.chatInputView.becomeFirstResponder()
            self.view.endEditing(true)
            
        
            
            imagePicker = ImagePickerController()
            imagePicker.delegate = self
            imagePicker.dataSource = self
            imagePicker.layoutConfiguration.showsFirstActionItem = false
            imagePicker.layoutConfiguration.showsSecondActionItem = false
            imagePicker.layoutConfiguration.showsCameraItem = false
            imagePicker.layoutConfiguration.numberOfAssetItemsInRow = 1
            imagePicker.imagePickerView.backgroundColor = .red
            imagePicker.collectionView.backgroundColor = .clear
            
            PHPhotoLibrary.requestAuthorization({ [unowned self] (_) in
                DispatchQueue.main.async {
                    
                    self.imagePicker.layoutConfiguration.scrollDirection = .horizontal
                    self.presentPickerAsInputView(self.imagePicker)
                    
                }
            })
             pickerIsShown = true
        }
    }
    
    func presentPickerAsInputView(_ vc: ImagePickerController) {
        //if you want to present view as input view, you have to set flexible height
        //to adopt natural keyboard height or just set an layout constraint height
        //for specific height.
        vc.view.autoresizingMask = .flexibleHeight
        vc.view.backgroundColor = UIColor.init(hexString: "cccfd6")
        
        currentInputView = vc.view
        currentInputView?.backgroundColor = UIColor.init(hexString: "cccfd6")
//        pickerContainer = vc.view
        
        
   
        
        self.view.layoutIfNeeded()
        
        reloadInputViews()
    }
    
    func uploadFile(image:UIImage){
        

        
        let url = "http://crm.nmma.co/upload-file"
        let imgData = UIImageJPEGRepresentation(image, 0.5)!
        let size = imgData.count
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
        bcf.countStyle = .file

        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")

        },
                         to:url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                   
                })
                
                upload.responseString { response in
                    print(response)
                    self.uploadUrl = response.value!
                    self.uploaded = ["url" : self.uploadUrl, "size" : size, "type" : "image/jpeg"]
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }
    
    var chatView: UIWebView = {
        let webview = UIWebView()
        webview.backgroundColor = .clear
        webview.scrollView.bounces = false
        return webview
    }()
    
  
    
    convenience init(chatId:String,title:String){
        self.init()
        self.conversationId = chatId
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        configureViews()

        initChat()
        

        let path = Bundle.main.bundlePath
        let url = URL.init(fileURLWithPath: path)

        self.isPickerActive = false
        self.chatView.scrollView.bounces = false
        self.chatView.loadHTMLString(self.css, baseURL: url)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        configLive()
        
        if conversationId != nil {
            subscribe()
        }
    }
    
    func configureViews(){
        self.view.backgroundColor = .white
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(color: .white), for: .default)
        let rightItem: UIBarButtonItem = {
            let rightImage = #imageLiteral(resourceName: "ic_profile")
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            //            button.addTarget(self, action: #selector(toggleSideMenu(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
//        self.navigationItem.rightBarButtonItem = rightItem
        chatView.delegate = self
        chatInputView.delegate = self
        self.view.addSubview(container)
        container.addSubview(chatView)
              
        self.view.addSubview(inputContainer)
        inputContainer.addSubview(chatInputView)
        self.view.addSubview(loader)
        

    }
    
    let currentUser = ErxesUser.sharedUserInfo()
    
    func initChat(){
   
        css = "<style>.row,.row .text{overflow:hidden}body{background:url(bg-1.png);background:#f4f4f4;padding:0;margin:0 20px}.row{position:relative;margin-bottom:10px;margin-top:15px;font-family:Roboto,Arial,sans-serif;font-weight:500}.row .text a{float:left;padding:12px 20px;background:#f6f4fb;border-radius:20px 20px 20px 2px;color:#444;margin-bottom:5px;margin-left:38px;margin-right:40px;font-size:14px;box-shadow:0 1px 1px 0 rgba(0,0,0,.2)}.me .text a{float:right;background:\(bg);color:#fff;border-radius:20px 2px 20px 20px;margin-left:50px;margin-right:38px;}.row .text img{max-width:100%;padding-top:3px}.row .date{color:#cbcbcb;font-size:11px;margin-left:36px}.me .date{text-align:right;margin-right:38px;}.row .img{float:left;position:absolute;bottom:17px;left:0;margin-right:8px}.row .img img{width:30px;height:30px;border-radius:15px;box-sizing:border-box;border:1px solid white;}.me .img{right:0;left:auto;right:0}.me .img img{margin-right:0;margin-left:8px}p{display:inline}</style>"
        
    }
    

    
    func loadMessages(){
        
        if conversationId == nil{
            return
        }

        print("loaded")

        let messagesQuery = ConversationDetailQuery(_id: self.conversationId!)
        client.fetch(query: messagesQuery, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
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
            if let allMessages = result?.data?.conversationDetail {
          
                let messagesArray = (allMessages.messages?.map {($0?.fragments.messageDetail)!})!
                var me = ""
                var str = ""
 
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

                for item in messagesArray {

                    let date = item.createdAt?.dateFromUnixTime()
                    let now = date?.hourMinutes!
                    
         

                    var avatar = "avatar.png"

                    if item.user != nil{
                        if let userAvatar = item.user?.details?.avatar{
                            avatar = userAvatar
                        }
                    }

                    me = ""
                    if item.userId != nil{
                            me = "me"
                    }

                    var image = ""

                    if let attachments = item.attachments{
                        if attachments.count > 0{
                            let attachment = attachments[0]
                            
                            if let url = attachment!["url"] as? String{
                                image = url
                            }
                            
                        }
                    }

                    let chat = item.content?.withoutHtml

                    str = str + "<div class=\"row \(me)\"><div class=\"img\"><img src=\"\(avatar)\"/></div><div class=\"text\"><a>\(chat!)<img src=\"\(image)\"/></a></div><div class=\"date\">\(now!)</div></div>"
                }
             

                self?.inited = true
                str = "document.body.innerHTML += '\(str)';window.location.href = \"inapp://scroll\""
                self?.chatView.stringByEvaluatingJavaScript(from: str)
                let scrollPoint = CGPoint(x: 0, y: (self?.chatView.scrollView.contentSize.height)! - (self?.chatView.frame.size.height)!)
                print(str)
                self?.chatView.scrollView.setContentOffset(scrollPoint, animated: true)
                self?.loader.stopAnimating()
            }
        }
    }
    
   @objc func sendMessage(_ sender:UIButton){
    if imagePicker.selectedAssets.count != 0 {
        for asset in imagePicker.selectedAssets {
            print("asset = ",asset)
            

            let requestOptions = PHImageRequestOptions()
            requestOptions.resizeMode = .exact
            requestOptions.deliveryMode = .highQualityFormat
            requestOptions.isSynchronous = true
            let manager = PHImageManager.default()
            manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: requestOptions) { (selectedImage, _) in
                            self.uploadFile(image: selectedImage!)
                            self.attachments = [JSON]()
                            self.attachments.append(self.uploaded)
            }
        }
        imagePicker = ImagePickerController()
    }
    let mutation = ConversationMessageAddMutation(conversationId: self.conversationId!, content: self.chatInputView.text!)
        client.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.chatInputView.text = ""
        }
    }
    
    func appendToChat(_ item:MessageSubs){
      
        if let message = item.payload?.data?.conversationMessageInserted{
            
            var str = ""
            
            if let content = message.content{
                str = content
            }
            
//            let now = NMFormatter.now()
            
            let date = Date()
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let now = String(format:"%i:%i",hour,minutes)
            
            var me = ""
            
            if message.user != nil {
                me = "me"
            }else{
                playSound()
            }
            
            var avatar = "avatar.png"
            
            if let userAvatar = message.user?.details?.avatar{
                avatar = userAvatar
            }
            
            var image = ""
            
            if message.attachments.count > 0{
                let attachment = message.attachments[0]
                if let img = attachment!.url{
                    image = img
                }
            }
            
            str = "<div class=\"row \(me)\"><div class=\"img\"><img src=\"\(avatar)\"/></div><div class=\"text\"><a>\(str)<img src=\"\(image)\"/></a></div><div class=\"date\">\(now)</div></div>"
            str = "document.body.innerHTML += '\(str)';window.location.href = \"inapp://scroll\""
            
            self.chatView.stringByEvaluatingJavaScript(from: str)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.container.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
//            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
//            (0.0, 521.0, 375.0, 291.0)
//            (0.0, 579.0, 375.0, 233.0)
        }
        
        self.inputContainer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(47)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        self.chatInputView.snp.makeConstraints { (make) in
            make.left.equalTo(container.snp.left).offset(10)
            make.right.equalTo(container.snp.right).inset(10)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        self.chatView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.inputContainer.snp.top)

        }
        
        self.loader.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view.snp.center)
        }
    }
    
    func moveTextField(){
        print("height = ", keyboardFrame.height)
        inputContainer.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).inset(keyboardFrame.height)
        }
        print("input = ",inputContainer.frame)
        container.snp.remakeConstraints({ (update) in
            update.bottom.equalTo(self.inputContainer.snp.top)
        })
        
        chatView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(container.snp.bottom)
        }
        
        self.view.layoutIfNeeded()
    }
}

extension ChatController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.sendMessage(self.chatInputView.text!)
        self.sendMessage(UIButton())
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
           print("will show")
            self.keyboardFrame = keyboardSize
            moveTextField()
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if Constants.SCREEN_HEIGHT == 812 {
            inputContainer.snp.remakeConstraints { (make) in
                make.bottom.equalTo(self.view.snp.bottom).inset(keyboardFrame.height+58)
            }
         
            container.snp.remakeConstraints({ (update) in
                update.bottom.equalTo(self.inputContainer.snp.top)
            })
            
            chatView.snp.remakeConstraints { (make) in
                make.bottom.equalTo(container.snp.bottom)
            }
            
            self.view.layoutIfNeeded()
        }
        pickerIsShown = false
        chatInputView.becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
}

extension ChatController: UIWebViewDelegate{
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.scheme == "inapp"{
            if request.url?.host == "scroll"{


                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    let scrollPoint = CGPoint(x: 0, y: self.chatView.scrollView.contentSize.height - self.chatView.frame.size.height)
                    self.chatView.scrollView.setContentOffset(scrollPoint, animated: true)
                })
                
                loader.stopAnimating()
                return false
            }
        }
        return true
    }
    
    
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if(!inited){
            loadMessages()
        }
        
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        loader.startAnimating()
    }
}

extension ChatController:LiveGQLDelegate{
    
    public func receivedRawMessage(text: String) {
        do{
           print(text)
            if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
                
                let item = try JSONDecoder().decode(MessageSubs.self, from: dataFromString)
               
                self.appendToChat(item)
            }
        }
        catch{
            print(error)
        }
    }
}

extension ChatController : ImagePickerControllerDelegate {
    
    public func imagePicker(controller: ImagePickerController, didSelectActionItemAt index: Int) {
        print("did select action \(index)")
        
        //before we present system image picker, we must update present button
        //because first responder will be dismissed
//        presentButton.isSelected = false
        
        if index == 0 && UIImagePickerController.isSourceTypeAvailable(.camera) {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            if let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) {
                vc.mediaTypes = mediaTypes
            }
            navigationController?.visibleViewController?.present(vc, animated: true, completion: nil)
        }
        else if index == 1 && UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            navigationController?.visibleViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    public func imagePicker(controller: ImagePickerController, didSelect asset: PHAsset) {
        print("selected assets: \(controller.selectedAssets.count)")
    
//        updateNavigationItem(with: controller.selectedAssets.count)
    }
    
    public func imagePicker(controller: ImagePickerController, didDeselect asset: PHAsset) {
        print("selected assets: \(controller.selectedAssets.count)")
//        updateNavigationItem(with: controller.selectedAssets.count)
    }
    
    public func imagePicker(controller: ImagePickerController, didTake image: UIImage) {
        print("did take image \(image.size)")
    }
    
    func imagePicker(controller: ImagePickerController, willDisplayActionItem cell: UICollectionViewCell, at index: Int) {
        switch cell {
        case let iconWithTextCell as IconWithTextCell:
            iconWithTextCell.titleLabel.textColor = UIColor.black
            switch index {
            case 0:
                iconWithTextCell.titleLabel.text = "Camera"
                iconWithTextCell.imageView.image = #imageLiteral(resourceName: "button-camera")
            case 1:
                iconWithTextCell.titleLabel.text = "Photos"
                iconWithTextCell.imageView.image = #imageLiteral(resourceName: "button-photo-library")
            default: break
            }
        default:
            break
        }
    }
    
    func imagePicker(controller: ImagePickerController, willDisplayAssetItem cell: ImagePickerAssetCell, asset: PHAsset) {
        switch cell {
            
        case let videoCell as CustomVideoCell:
            videoCell.label.text = ChatController.durationFormatter.string(from: asset.duration)
            
            
        case let imageCell as CustomImageCell:
            if asset.mediaSubtypes.contains(.photoLive) {
                imageCell.subtypeImageView.image = #imageLiteral(resourceName: "icon-live")
            }
            else if asset.mediaSubtypes.contains(.photoPanorama) {
                imageCell.subtypeImageView.image = #imageLiteral(resourceName: "icon-pano")
            }
            else if #available(iOS 10.2, *), asset.mediaSubtypes.contains(.photoDepthEffect) {
                imageCell.subtypeImageView.image = #imageLiteral(resourceName: "icon-depth")
            }
        default:
            break
        }
    }
    
}

extension ChatController: ImagePickerControllerDataSource {
    
    func imagePicker(controller: ImagePickerController, viewForAuthorizationStatus status: PHAuthorizationStatus) -> UIView {
        let infoLabel = UILabel(frame: .zero)
        infoLabel.backgroundColor = UIColor.green
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        switch status {
        case .restricted:
            infoLabel.text = "Access is restricted\n\nPlease open Settings app and update privacy settings."
        case .denied:
            infoLabel.text = "Access is denied by user\n\nPlease open Settings app and update privacy settings."
        default:
            break
        }
        return infoLabel
    }
    
}

extension ChatController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImg:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true) {
            self.uploadFile(image: originalImg!)
            self.chatInputView.becomeFirstResponder()
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true , completion: nil)
        chatInputView.becomeFirstResponder()
    }
}

extension ChatController: UINavigationControllerDelegate {
    
}

