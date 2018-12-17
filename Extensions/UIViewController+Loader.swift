//
//  UIViewController+Loader.swift
//  erxes-ios
//
//  Created by alternate on 12/5/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func startLoader(root:UIView, offset:CGFloat = 0) {
        
        if self.view.viewWithTag(400) != nil {
            return
        }
        
        let width = root.frame.size.width
        let height = root.frame.size.height
        
        let rect = CGRect(x: 0, y: 0 - offset, width: width, height: height)
        let rect2 = CGRect(x: 0, y: 0, width: width, height: height)
        
        let emptyView = UIView(frame: rect)
        emptyView.tag = 400
        
        let messageLabel = UILabel(frame: rect2)
        messageLabel.text = "Please wait..."
        messageLabel.textColor = UIColor.gray
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        emptyView.addSubview(messageLabel)
        
        self.view.addSubview(emptyView)
        
        let frame = CGRect(x: width/2 - 25, y: height/2 - 60, width: 50, height: 50)
        let loader = NVActivityIndicatorView(frame: frame, type: .ballTrianglePath, color: UIColor.ERXES_COLOR, padding: 10)
        emptyView.addSubview(loader)
        loader.startAnimating()
    }
    
    func stopLoader() {
        self.view.viewWithTag(400)?.removeFromSuperview()
    }
}
