//
//  ChatController+TableView.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/8/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser

extension ChatController:UICollectionViewDelegate {
    
}

extension ChatController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = messages[indexPath.row]
        var cellId:String
        
        if item.formWidgetData != nil {
            cellId = FormCell.ID
        } else if let files = item.attachments, files.count > 0 {
            cellId = ImageCell.ID
        } else if item.customerId != nil {
            cellId = IncomingCell.ID
        } else {
            cellId = SentCell.ID
        }

        let cell = chatView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? ChatBaseCell {
            cell.customer = customer
            cell.viewModel = messages[indexPath.row]
        }
        
        if let cell = cell as? ImageCell {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
            cell.ivAttachment.tag = indexPath.row
            cell.ivAttachment.addGestureRecognizer(tapGestureRecognizer)
        }
        
        return cell
    }
    
    @objc func imageTapped(sender:UITapGestureRecognizer) {
        
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        let message = messages[imageView.tag]
        
        var images = [SKPhoto]()
        if let attachments = message.attachments,attachments.count > 0 {
            
            for attachment in attachments {
                if let url = attachment?["url"] as? String {
                    let photo = SKPhoto.photoWithImageURL(url)
                    photo.shouldCachePhotoURLImage = false
                    images.append(photo)
                }
            }
        }
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
}

extension ChatController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = messages[indexPath.row]
        
        var height:CGFloat = 0
        
        if indexPath.row < calculatedHeights.count {
            height = calculatedHeights[indexPath.row]
        } else {
            if item.formWidgetData != nil {
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
