//
//  UIColor.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    static let ERXES_COLOR = UIColor(red: 86 / 255, green: 41 / 255, blue: 182 / 255, alpha: 1.0)
    static let TEXT_COLOR = UIColor(red: 96 / 255, green: 96 / 255, blue: 96 / 255, alpha: 1.0)
    static let CELL_COLOR = UIColor(red: 248 / 255, green: 244 / 255, blue: 249 / 255, alpha: 1.0)
    static let KEYBOARD_COLOR = UIColor(red: 209 / 255, green: 213 / 255, blue: 218 / 255, alpha: 1.0)
    static let GRAY_COLOR = UIColor(red: 98 / 255, green: 99 / 255, blue: 99 / 255, alpha: 1.0)
    static let LIGHT_GRAY_COLOR = UIColor(red: 160 / 255, green: 160 / 255, blue: 160 / 255, alpha: 0.6)
    static let SHIMMER_COLOR = UIColor(red: 202 / 255, green: 202 / 255, blue: 202 / 255, alpha: 1.0)
    static let INBOX_BG_COLOR = UIColor(red: 245 / 255, green: 244 / 255, blue: 250 / 255, alpha: 1.0)
    static let FB_COLOR = UIColor(red: 59 / 255, green: 89 / 255, blue: 152 / 255, alpha: 1.0)
    static let GREEN = UIColor(red: 55 / 255, green: 206 / 255, blue: 73 / 255, alpha: 1.0)
    
    
    func isLight() -> Bool
    {
        let components = self.cgColor.components
        let brightness = ((components![0] * 299) + (components![1] * 587) + (components![2] * 114)) / 1000
        
        if brightness < 0.5 {
            return false
        } else {
            return true
        }
    }
    
}
