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
        
        if let str = viewModel?.content?.convertHtml(){
            
            if viewModel?.internal ?? false {
                tvText.backgroundColor = UIColor(hexString: "#fffccc")
                edgeView.backgroundColor = UIColor(hexString: "#fffccc")
                str.addAttribute(NSAttributedStringKey.font, value: UIFont.fontWith(type: .comfortaa, size: 13), range: NSMakeRange(0, str.length))
                str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSMakeRange(0, str.length))
                
            } else {
                tvText.backgroundColor = .ERXES_COLOR
                edgeView.backgroundColor = .ERXES_COLOR
                str.addAttribute(NSAttributedStringKey.font, value: UIFont.fontWith(type: .comfortaa, size: 13), range: NSMakeRange(0, str.length))
                str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, str.length))
            }
            DispatchQueue.main.async{
                self.tvText.attributedText = str
            }
        }
    }
    
    override func layoutView() {
        ivAvatar.snp.remakeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.top.equalTo(contentView.snp.top)
            make.width.height.equalTo(30)
        }
        tvText.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(55)
            make.right.equalTo(ivAvatar.snp.left).offset(-5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        lblDate.snp.remakeConstraints { (make) in
            make.left.equalTo(tvText.snp.left)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        edgeView.snp.remakeConstraints { (make) in
            make.top.equalTo(tvText.snp.top)
            make.right.equalTo(tvText.snp.right)
            make.width.height.equalTo(10)
        }
    }
}
