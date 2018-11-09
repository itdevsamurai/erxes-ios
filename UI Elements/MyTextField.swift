//
//  MyTextField.swift
//  NMG.CRM
//
//  Created by soyombo bat-erdene on 4/6/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class MyTextField: UITextField, UITextFieldDelegate {

    fileprivate var rightImage = UIImageView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
       
        
        self.textColor = .GRAY_COLOR
        self.font = Font.regular(16)
        
        
        
    }
    

    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        rightImage = UIImageView()
        rightImage.sizeToFit()
        rightImage.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
        self.rightViewMode = .whileEditing
        self.rightView = rightImage
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.LIGHT_GRAY_COLOR.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validate(type: TextFieldType) -> Bool {
        
        let valid = self.isValid(type: type)
        if !valid {
            rightImage.image = #imageLiteral(resourceName: "ic_xMark")
            rightImage.image? = (rightImage.image?.withRenderingMode(.alwaysTemplate))!
            rightImage.tintColor = .ERXES_COLOR
            self.rightView = rightImage
        } else {
            rightImage.image = #imageLiteral(resourceName: "ic_checkMark")
            self.rightView = rightImage
        }
        return valid
    }
    
    private func isValid(type: TextFieldType) -> Bool{
        if let txt = self.text {
            if txt.isEmpty{
                return false
            } else {
                switch type {
                case .password:
                    if txt.count < 4 {
                        return false
                    }
                   return true
                case .email:
                    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,6}"
                    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                    return emailTest.evaluate(with: txt)
                }
            }
        }
        return false
    }

}

enum TextFieldType {
    case email
    case password
}
