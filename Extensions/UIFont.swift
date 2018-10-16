//
//  UIFont.swift
//  erxes-ios
//
//  Created by alternate on 10/16/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

//public extension UIFont {
//    enum FontType: String {
//        case comfortaa = "Comfortaa"
//        case comfortaaBold = "Comfortaa-Bold"
//        case light = ".SFUIText-Light"
//    }
//    
//    public class func fontWith(type: FontType, size: CGFloat) -> UIFont {
//        return UIFont(name: type.rawValue, size: size)!
//    }
//}

class Font {
    static func regular(_ size: CGFloat = 14) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func light(_ size: CGFloat = 14) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func bold(_ size: CGFloat = 14) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
