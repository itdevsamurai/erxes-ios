//
//  ColChatDataSource.swift
//  erxes-ios
//
//  Created by alternate on 9/8/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import Apollo
import LiveGQL
import Alamofire
import Photos

public protocol ChatManagerDelegate:NSObjectProtocol {
    func chatUpdated(_ data: [MessageDetail])
    func messageRecieve(message:MessageDetail)
}

public protocol FileUploader:NSObjectProtocol {
    
}

public protocol BaseChatManager {
    func refresh()
}

class ChatManager:NSObject {
    
    let gql = LiveGQL(socket: Constants.SUBSCRITION_ENDPOINT)
    
    var conversationId:String?
    var delegate: ChatManagerDelegate?
    
    //attach properties
    var remoteUrl = ""
    var uploaded = JSON()
    var attachments = [JSON]()
    var size = 0
    
    override init() {
        super.init()
        gql.delegate = self
    }
    
    func queryMessages() {
        if conversationId == nil{
            return
        }
        
        let messagesQuery = ConversationDetailQuery(_id: self.conversationId!)
        appnet.fetch(query: messagesQuery, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
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
                self?.delegate?.chatUpdated(messagesArray)
            }
        }
    }
    
    func markAsRead(id:String){
        let mutation = ConversationMarkAsReadMutation(id: id)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func mutateAddMessage(msg:String){
        let mutation = ConversationMessageAddMutation(conversationId: self.conversationId!)
        
        if msg.count > 0 {
            mutation.content = msg
        }
        
        if attachments.count > 0 {
            mutation.attachments = attachments
        }
        
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(result)
            self?.attachments = [JSON]()
        }
    }
    
    func handleMessages(){
        
    }
}

extension ColChatController:ChatManagerDelegate {
    
    func chatUpdated(_ data: [MessageDetail]) {
        messages = data
        updateView()
        refresher.endRefreshing()
        loader.stopAnimating()
    }
    
    func messageRecieve(message:MessageDetail) {
        messages.append(message)
        loader.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.scrollToBottom()
        }
//        chatView.performBatchUpdates({
////            let deleteIndexPaths = Array(0…2).map { IndexPath(item: $0, section: 0) }
////            collectionView.deleteItems
////            let insertIndexPaths = Array(3…5).map { IndexPath(item: $0, section: 0) }
//            let n = messages.count - 1
//            chatView.insertItems(at: Array(n...n).map {IndexPath(item: $0, section: 0)})
//        }, completion: nil)
    }
}

extension ChatManager: LiveGQLDelegate{
    
    func subscribe(){
        gql.subscribe(graphql: "subscription{conversationMessageInserted(_id:\"\(self.conversationId!)\"){_id,content,userId,createdAt,customerId,user{_id,details{avatar}},attachments}}", variables: nil, operationName: nil, identifier: "conversationMessageInserted")
    }
    
    public func receivedRawMessage(text: String) {
        do{
            print(text)
            if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
                
                let result = try JSONDecoder().decode(MessageSubs.self, from: dataFromString)
                
                guard let item = result.payload?.data?.conversationMessageInserted else {
                    return
                }
    
                var message = MessageDetail(id:(item._id)!, content:item.content, userId:item.userId, createdAt: item.createdAt)
                
                if item.attachments.count > 0, let attachment = item.attachments.first {
                    var attachments = [JSON]()
                    var file = JSON()
                    file["url"] = attachment?.url
                    file["type"] = attachment?.type
                    file["size"] = attachment?.size
                    attachments.append(file)
                    message.attachments = attachments
                }
                
                delegate?.messageRecieve(message: message)
            }
        }
        catch{
            print(error)
        }
    }
}

extension ChatManager:FileUploader {
    
    func uploadFile(image:UIImage) {
        
//        self.uploadView.isHidden = false
//        self.progress.progress = 0
//        self.uploadLoader.startAnimating()
        
        let url = Constants.URL_UPLOAD
        
        if let imgData = UIImage.resize(image) as? Data{
            size = imgData.count
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useKB]
            bcf.countStyle = .file
//            self.lblFilesize.text = bcf.string(fromByteCount: Int64(size))
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
            },
                             to:url ) {
                                (result) in
                                
                                switch result {
                                case .success(let upload, _, _):
                                    self.processUpload(upload)
                                case .failure(let encodingError):
                                    print(encodingError)
                                }
            }
        }
    }
    
    func processUpload(_ upload:UploadRequest) {
        upload.uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
//            self.progress.progress = Float(progress.fractionCompleted)
        })
        
        upload.responseString { response in
            print(response)
            self.remoteUrl = response.value!
            self.uploaded = ["url" : self.remoteUrl, "size" : self.size, "type" : "image/jpeg"]
//            self.uploadLoader.stopAnimating()
//            self.uploadView.isHidden = false
            self.attachments = [JSON]()
            self.attachments.append(self.uploaded)
            self.mutateAddMessage(msg: "image")
        }
    }
}

extension ChatManager:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            ivPicked.image = chosenImage
            uploadFile(image: chosenImage)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
