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
        
        
        
        titleLabel = UILabel ()
        titleLabel.font = UIFont.fontWith(type: .light, size: 14    )
        titleLabel.textColor = .TEXT_COLOR
        
        self.addSubview(titleLabel)
        
        textField = UITextField ()
        textField.delegate = self
        textField.font = UIFont.fontWith(type: .light, size: 14    )
        textField.borderStyle = .none
        textField.textColor = .TEXT_COLOR
        let lineView = UIView()
        lineView.tag = 1
        lineView.backgroundColor = .TEXT_COLOR
        self.addSubview(lineView)
        
        let leftView = UIView(frame: CGRect(x:0, y:0, width:20, height:30))
        textField.leftView = leftView
        textField.leftViewMode = .always
        self.addSubview(textField)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(30)

        }
        
        lineView.snp.makeConstraints { (make) in
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
