//
//  ErxesFontKit.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/20/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreText

public extension UIFont {
    public class func erxes(of size: CGFloat) -> UIFont {
        let name = "erxes"
        return UIFont(name: name, size: size)!
    }
}

public extension String {

    public static func erxes(with name: ErxesFont) -> String {
        let substr = name.rawValue[..<name.rawValue.index(name.rawValue.startIndex, offsetBy: 1)]
        return String(substr)
        
    }
    
}

public extension UIImage {

    public static func erxes(with name: ErxesFont,
                               textColor: UIColor,
                               size: CGSize = CGSize(width: 22, height: 22),
                               backgroundColor: UIColor = UIColor.clear) -> UIImage {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        let fontSize = min(size.width, size.height)
        let attributedString = NSAttributedString(
            string: String.erxes(with: name),
            attributes: [
                NSAttributedStringKey.font: UIFont.erxes(of: fontSize),
                NSAttributedStringKey.foregroundColor: textColor,
                NSAttributedStringKey.backgroundColor: backgroundColor,
                NSAttributedStringKey.paragraphStyle: paragraph
            ]
        )
        
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.draw(in:
            CGRect(
                x: 0,
                y: (size.height - fontSize) / 2,
                width: size.width,
                height: fontSize
            )
        )
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
