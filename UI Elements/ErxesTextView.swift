//
//  ErxesTextView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/31/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ErxesTextView: UIView {

    var titleLabel = UILabel()
    var textView = UITextView()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let titlebg = UIView()
        titlebg.backgroundColor = UIColor.init(hexString: "ebebeb")
        self.addSubview(titlebg)
        
        titleLabel = UILabel ()
        titleLabel.font = Font.regular(12)
        titleLabel.textColor = .black
        titleLabel.text = titleLabel.text?.capitalized
        titlebg.addSubview(titleLabel)
        
        textView = UITextView()
        textView.delegate = self
        textView.font = Font.regular(15)
        textView.backgroundColor = .clear
        textView.textColor = .black
        let lineView = UIView()
        lineView.tag = 1
        lineView.backgroundColor = .TEXT_COLOR
        self.addSubview(lineView)
        
     
        self.addSubview(textView)
        
        
        titlebg.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(55)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(55)
            make.right.equalTo(-16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
            
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}

extension ErxesTextView: UITextViewDelegate {
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
