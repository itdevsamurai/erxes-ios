//
//  ErxesField.swift
//  Erxes.io
//
//  Created by soyombo bat-erdene on 2/20/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit


class ErxesField: UIView {

    
    var titleLabel = UILabel()
    var textField = UITextField()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titlebg = UIView()
        titlebg.backgroundColor = UIColor.init(hexString: "ebebeb")
        self.addSubview(titlebg)
        
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "ebebeb")
        self.addSubview(line)
        line.tag = 1
        titleLabel = UILabel ()
        titleLabel.font = Font.regular(12)
        titleLabel.textColor = .black
        
        
        titlebg.addSubview(titleLabel)
        
        textField = UITextField ()
        textField.delegate = self
        textField.font = Font.regular(15)
        textField.borderStyle = .none
        textField.textColor = .black

        self.addSubview(textField)
        
        titlebg.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(55)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(55)
            make.right.equalTo(-16)
            make.bottom.equalTo(-10)

        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        

    }
    
}

extension ErxesField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    //    func textfieldte
}
