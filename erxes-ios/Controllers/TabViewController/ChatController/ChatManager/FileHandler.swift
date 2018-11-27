//
//  FileHandler.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/9/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Photos

extension ChatManager:FileUploader {
    
    func uploadFile(image:UIImage) {
        
        let url = Constants.URL_UPLOAD
        
        if let imgData = UIImage.resize(image) {
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
            self.mutateAddMessage(msg: "image", isInternal: false, mentions: [])
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
