//
//  TextCell.swift
//  erxes-ios
//
//  Created by alternate on 9/4/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class SentCell: ChatBaseCell {
    
    static let ID = "SentCell"
    
    override func updateView() {
        
        super.updateView()
        
        lblDate.textAlignment = .right
        
        if let str = viewModel?.content?.convertHtml(){
            str.addAttribute(NSAttributedStringKey.font, value: UIFont.fontWith(type: .regular, size: 14), range: NSMakeRange(0, str.length))
            str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, str.length))
            tvText.attributedText = str
        }
    }
    
    override func layoutView() {
        ivAvatar.snp.remakeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
            make.width.height.equalTo(30)
        }
        lblDate.snp.remakeConstraints { (make) in
            make.right.equalTo(ivAvatar.snp.left).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        tvText.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(55)
            make.right.equalTo(ivAvatar.snp.left).offset(-5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        edgeView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(tvText.snp.bottom)
            make.right.equalTo(tvText.snp.right)
            make.width.height.equalTo(10)
        }
        tvText.backgroundColor = .ERXES_COLOR
        edgeView.backgroundColor = .ERXES_COLOR
    }
}
