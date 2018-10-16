//
//  UIFont.swift
//  erxes-ios
//
//  Created by alternate on 10/16/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    enum FontType: String {
        case comfortaa = "Comfortaa"
        case comfortaaBold = "Comfortaa-Bold"
        case light = ".SFUIText-Light"
    }
    
    public class func fontWith(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
