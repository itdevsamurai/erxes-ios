//
//  Filter+Keyboard.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/1/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

extension FilterController {
    @objc func keyboardHandler(notification: NSNotification) {
        let info = notification.userInfo!
        guard let keyBoardInfo = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
            
        }
        let keyboardFrame = keyBoardInfo.cgRectValue
        
        if notification.name == .UIKeyboardWillShow {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
        } else {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
}
