//
//  UIViewController+Extensions.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    func presentAlert(title: String?, msg:String, style:UIAlertControllerStyle = .alert, confirmKey:String? = "OK", confirmAction:@escaping ()->Void) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: style)
        let mutableTitle = NSMutableAttributedString(string: title!)
        let mutableMsg = NSMutableAttributedString(string: msg)
       
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.fontWith(type: .comfortaa, size: 15)
        ]
        let msgAttrs = [
            NSAttributedStringKey.foregroundColor: UIColor.GRAY_COLOR,
            NSAttributedStringKey.font: UIFont.fontWith(type: .comfortaa, size: 15)
        ]

        mutableTitle.addAttributes(attrs, range: NSRange(location: 0, length: (title?.count)!))
        mutableMsg.addAttributes(msgAttrs, range: NSRange(location: 0, length: msg.count))
     
        alertController.setValue(mutableTitle, forKey: "attributedTitle")
        alertController.setValue(mutableMsg, forKey: "attributedMessage")
        let action = UIAlertAction(title: confirmKey, style: .default) { (action) in
            confirmAction()
        }
        action.setValue(UIColor.ERXES_COLOR, forKey: "titleTextColor")
        alertController.addAction(action)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
            self.dismiss(animated: true, completion: nil)
        }
        cancelAction.setValue(UIColor.ERXES_COLOR, forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true,completion: nil)
        }
    }
    
    func presentTextFieldAlert(title: String?, msg:String, style:UIAlertControllerStyle = .alert, confirmKey:String? = "OK", confirmAction:@escaping (_ returnValue:String?)->Void){
        let alertController = UIAlertController(title: title, message: "", preferredStyle: style)
        let mutableTitle = NSMutableAttributedString(string: title!)

        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.fontWith(type: .comfortaa, size: 15)
        ]
    
        
        mutableTitle.addAttributes(attrs, range: NSRange(location: 0, length: (title?.count)!))
        
        
        alertController.setValue(mutableTitle, forKey: "attributedTitle")
        
        
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.textColor = UIColor.GRAY_COLOR
            textField.font = UIFont.fontWith(type: .comfortaa, size: 15)
            textField.placeholder = msg
            textField.tintColor = .ERXES_COLOR
        }
        
        let action = UIAlertAction(title: confirmKey, style: .default) { (action) in
            if let textField = alertController.textFields?.first{
                confirmAction(textField.text)
            }
            
        }
        action.setValue(UIColor.ERXES_COLOR, forKey: "titleTextColor")
        alertController.addAction(action)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
            self.dismiss(animated: true, completion: nil)
        }
        cancelAction.setValue(UIColor.ERXES_COLOR, forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true,completion: nil)
        }
    }
}

