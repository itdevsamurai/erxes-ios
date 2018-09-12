//
//  ErxesTextView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/31/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
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
        
        
        
        titleLabel = UILabel ()
        titleLabel.font = UIFont.fontWith(type: .light, size: 14    )
        titleLabel.textColor = .TEXT_COLOR
        titleLabel.text = titleLabel.text?.capitalized
        self.addSubview(titleLabel)
        
        textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.fontWith(type: .light, size: 14    )
        textView.backgroundColor = .clear
        textView.textColor = .TEXT_COLOR
        let lineView = UIView()
        lineView.tag = 1
        lineView.backgroundColor = .TEXT_COLOR
        self.addSubview(lineView)
        
     
        self.addSubview(textView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
            
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}

extension ErxesTextView: UITextViewDelegate {
    



}
