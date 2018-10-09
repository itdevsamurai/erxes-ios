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
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = manager
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.navigationBar.tintColor = .black // Cancel button ~ any UITabBarButton items
            imagePicker.navigationBar.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor : UIColor.black
            ]
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert:UIAlertController = UIAlertController(title: "Camera Unavailable", message: "Unable to find a camera on this device", preferredStyle: UIAlertControllerStyle.alert)
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
        guard let message = chatInputView.text, message.count > 0 else {
            return
        }
        manager.mutateAddMessage(msg: message, isInternal: isInternal, mentions: mentionController.mentionedUserIds())
        chatInputView.text = ""
        mentionController.clear()
        btnInternalNote.isSelected = false
        isInternal = false
    }
    
    @objc func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = manager
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.navigationBar.tintColor = .black // Cancel button ~ any UITabBarButton items
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
                } else {
                }
            })
        } else {
            self.openImagePicker()
        }
    }
}
