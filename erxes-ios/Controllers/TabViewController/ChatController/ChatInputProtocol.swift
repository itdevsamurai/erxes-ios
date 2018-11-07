//
//  ChatInputProtocol.swift
//  erxes-ios
//
//  Created by alternate on 10/8/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension ChatController:ChatInputProtocol {
    
    @objc func btnCameraClick() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = manager
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.navigationBar.tintColor = .black // Cancel button ~ any UITabBarButton items
            imagePicker.navigationBar.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor : UIColor.black
            ]
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert:UIAlertController = UIAlertController(title: "Camera Unavailable",
                                                            message: "Unable to find a camera on this device",
                                                            preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func btnAttachmentClick() {
        checkPermission()
    }
    
    @objc func btnInternalNoteClick() {
        isInternal = !isInternal
        btnInternalNote.isSelected = isInternal
    }
    
    @objc func btnSendClick() {
        guard var message = chatInputView.text, message.count > 0 else {
            return
        }
        
        let pattern = "@[a-zA-Z0-9._]*"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, message.count)
        let matches = (regex?.matches(in: message, options: [], range: range))!
        
        if mentionController.mentionedUsers.count > 0 {
            for match in matches.reversed() {
                let begin = message.index(message.startIndex, offsetBy: match.range.location)
                let end = message.index(message.startIndex, offsetBy: match.range.location + match.range.length)
                let range = begin..<end
                var str = String(message[range])
                
                str = "<b>" + str + "</b>"
                
                message = message.replacingCharacters(in: range, with: str)
            }
        }
        
        manager.mutateAddMessage(msg: message, isInternal: isInternal, mentions: mentionController.mentionedUserIds())
        mentionController.mentionedUsers = []
        chatInputView.text = ""
        mentionController.clear()
        btnInternalNote.isSelected = false
        isInternal = false
    }
    
    @objc func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = manager
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.navigationBar.tintColor = .black
        imagePicker.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.black
        ]
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
                }
            })
        } else {
            self.openImagePicker()
        }
    }
}
