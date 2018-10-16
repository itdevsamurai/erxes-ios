//
//  UIImageView.swift
//  erxes-ios
//
//  Created by alternate on 10/16/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageWithString(text: String, backGroundColor: UIColor, attributes: [NSAttributedStringKey: Any]) {
        
        let displayString: NSMutableString = NSMutableString(string: "")
        displayString.append(text.initials)
        
        
        
        let scale: Float = Float(UIScreen.main.scale)
        var size: CGSize = self.bounds.size
        
        if (self.contentMode == .scaleToFill ||
            self.contentMode == .scaleAspectFill ||
            self.contentMode == .scaleAspectFit ||
            self.contentMode == .redraw)
        {
            size.width = CGFloat(floorf(Float(size.width) * scale) / scale)
            size.height = CGFloat(floorf(Float(size.height) * scale) / scale)
        }
        
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            print("Context  nil")
            return
        }
        
        let path = CGPath(ellipseIn: self.bounds, transform: nil)
        
        context.addPath(path)
        
        
        context.clip()
        context.setFillColor(backGroundColor.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height));
        
        let textSize = displayString.size(withAttributes: attributes)
        
        
        displayString.draw(in: CGRect(x: bounds.size.width / 2 - textSize.width / 2, y: bounds.size.height / 2 - textSize.height / 2, width: textSize.width, height: textSize.height), withAttributes: attributes)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        self.image = image
    }
    
    func fontName(fontName: String) -> UIFont {
        let fontSize: CGFloat = self.bounds.width * 40
        if fontName.count != 0 {
            return UIFont(name: fontName, size: fontSize)!
        } else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
}
