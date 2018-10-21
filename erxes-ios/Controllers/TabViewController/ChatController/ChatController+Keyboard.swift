//
//  ColChatController+KeyboardHandler.swift
//  erxes-ios
//
//  Created by alternate on 9/7/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

extension ChatController {
    
    @objc func keyboardHandler(notification: NSNotification) {
        let info = notification.userInfo!
        guard let keyBoardInfo = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
            
        }
        var keyboardFrame = keyBoardInfo.cgRectValue
        
        if notification.name == .UIKeyboardWillShow {
            container.snp.remakeConstraints { (make) in
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.right.left.equalToSuperview()
                make.bottom.equalToSuperview().inset(keyboardFrame.size.height)
            }
            
//            inputContainer.snp.updateConstraints { (make) in
//                make.bottom.equalToSuperview()
//            }
        } else {
            container.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview()
            }
        }
    }
}
