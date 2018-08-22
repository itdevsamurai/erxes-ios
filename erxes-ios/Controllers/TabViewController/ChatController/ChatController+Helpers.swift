//
//  ChatController+Helpers.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 6/27/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

extension ChatController {
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        if result == true {
            currentInputView = nil
        }
        return result
    }
    
    override var inputView: UIView? {
        return currentInputView
    }
    
//    override var inputAccessoryView: UIView? {
//        //        self.inputContainer.snp.makeConstraints { (make) in
//        //            make.left.right.equalToSuperview()
//        //            make.height.equalTo(47)
//        //            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
//        //        }
//        return inputContainer
//    }
    
    static let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
}
