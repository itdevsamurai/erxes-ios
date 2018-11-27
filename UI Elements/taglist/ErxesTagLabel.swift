//
//  TagView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/24/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ErxesTagLabel: UILabel {
    
    
    convenience init (title:String, backgroundColor: UIColor) {
        self.init()
        self.commonInit(backgroundColor: backgroundColor)
        self.text = title
        let size = self.intrinsicContentSize
        self.frame = CGRect(x: 0, y: 0, width: size.width+10, height: 18)
    }
    
    func commonInit(backgroundColor:UIColor) {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        
        self.font = Font.regular(10)
        self.backgroundColor = backgroundColor
        self.textAlignment = .center
        if backgroundColor.isLight() {
            self.textColor = .black
        } else {
            self.textColor = .white
        }
        
    }
   
}
