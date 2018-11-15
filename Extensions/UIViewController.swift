//
//  File.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func navigate(_ navigation: MyNavigation) {
        navigate(navigation as Navigation)
    }
    
    func showResult(isSuccess: Bool, message: String, resultCompletion: (() -> Void)? = nil) {
        let bannerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (UINavigationController().navigationBar.frame.height)))
        if isSuccess {
            bannerView.backgroundColor = UIColor.init(hexString: "37ce49")
        } else {
            bannerView.backgroundColor = UIColor.red
        }
        navigationController?.navigationBar.addSubview(bannerView)
        let notifyLabel = UILabel()
        notifyLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (UINavigationController().navigationBar.frame.height))
        notifyLabel.backgroundColor = UIColor.clear
        notifyLabel.text = message
        notifyLabel.textAlignment = .center
        notifyLabel.textColor = .white
        notifyLabel.font = Font.light(14)
        bannerView.addSubview(notifyLabel)
        
        bannerView.center.y -= (navigationController?.navigationBar.bounds.height)!
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.curveEaseIn, animations: {
            bannerView.center.y += (self.navigationController?.navigationBar.frame.height)!
            
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 1, delay: 1.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                bannerView.center.y -= ((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
                
            }, completion: { completed in
                bannerView.removeFromSuperview()
                if (resultCompletion != nil) {
                    resultCompletion!()
                }
            })
            
        })
    }
    
    func showLoader() {
        
        if let navHeight = navigationController?.navigationBar.frame.height {
            let indicator1 = UIView(frame: CGRect(x: -60, y: navHeight - 4, width: 60, height: 4))
            let indicator2 = UIView(frame: CGRect(x: Constants.SCREEN_WIDTH, y: navHeight - 4, width: 60, height: 4))
            indicator1.backgroundColor = .white
            indicator2.backgroundColor = .white
            navigationController?.navigationBar.addSubview(indicator1)
            navigationController?.navigationBar.addSubview(indicator2)
            UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
                indicator1.frame = CGRect(x: Constants.SCREEN_WIDTH, y: navHeight - 4, width: 60, height: 4)
                indicator2.frame = CGRect(x: -60, y: navHeight - 4, width: 60, height: 4)
            })
        }
    }
    
    func hideLoader() {
        if let subViews = navigationController?.navigationBar.subviews {
            for subView in subViews{
                subView.layer.removeAllAnimations()
            }
        }
    }
}

public extension UIViewController {
    func presentAlert(title: String?, msg:String, style:UIAlertControllerStyle = .alert, confirmKey:String? = "OK", confirmAction:@escaping ()->Void) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: style)
        let mutableTitle = NSMutableAttributedString(string: title!)
        let mutableMsg = NSMutableAttributedString(string: msg)
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: Font.regular(15)
        ]
        let msgAttrs = [
            NSAttributedStringKey.foregroundColor: UIColor.GRAY_COLOR,
            NSAttributedStringKey.font: Font.regular(15)
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
    
    func presentTextFieldAlert(title: String?, msg:String, style:UIAlertControllerStyle = .alert, confirmKey:String? = "OK", confirmAction:@escaping (_ returnValue:String?)->Void) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: style)
        let mutableTitle = NSMutableAttributedString(string: title!)
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: Font.regular(15)
        ]
        
        
        mutableTitle.addAttributes(attrs, range: NSRange(location: 0, length: (title?.count)!))
        
        
        alertController.setValue(mutableTitle, forKey: "attributedTitle")
        
        
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.textColor = UIColor.GRAY_COLOR
            textField.font = Font.regular(15)
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
