//
//  MyButton.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/31/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    var shadowLayer: CAShapeLayer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = Font.regular(15)
      
        self.setTitleColor(.white, for: .normal)
        print("BUTTON INIT")
        
    }
    
    func setup(){
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
            shadowLayer.fillColor = UIColor.ERXES_COLOR.cgColor
            
            shadowLayer.shadowColor = UIColor.GRAY_COLOR.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            print("SHADOWWW")
            print(bounds)
            layer.insertSublayer(shadowLayer, at: 0)
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
   
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        print("button layout")
        self.setup()
    }

}
