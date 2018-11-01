//
//  ChatController+TableView.swift
//  erxes-ios
//
//  Created by alternate on 10/8/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
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
        var cell:ChatBaseCell
        
        if item.formWidgetData != nil {
            cell = chatView.dequeueReusableCell(withReuseIdentifier: FormCell.ID, for: indexPath) as! FormCell
        } else
            if let files = item.attachments, files.count > 0 {
                let imageCell = chatView.dequeueReusableCell(withReuseIdentifier: ImageCell.ID, for: indexPath) as! ImageCell
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
                imageCell.ivAttachment.tag = indexPath.row
                imageCell.ivAttachment.addGestureRecognizer(tapGestureRecognizer)
                cell = imageCell
            } else
                if item.customerId != nil {
                    cell = chatView.dequeueReusableCell(withReuseIdentifier: IncomingCell.ID, for: indexPath) as! IncomingCell
                } else {
                    cell = chatView.dequeueReusableCell(withReuseIdentifier: SentCell.ID, for: indexPath) as! SentCell
        }
        cell.viewModel = messages[indexPath.row]
        return cell
    }
    
    @objc func imageTapped(sender:UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let message = messages[imageView.tag]
        
        var images = [SKPhoto]()
        if let attachments = message.attachments,attachments.count > 0 {
            
            for attachment in attachments {
                let photo = SKPhoto.photoWithImageURL(attachment!["url"] as! String)
                photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
                images.append(photo)
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
        
        if indexPath.row < calculatedHeights.count{
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
