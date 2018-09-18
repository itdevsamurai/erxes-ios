//
//  InComingCell.swift
//  erxes-ios
//
//  Created by alternate on 9/11/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class IncomingCell: ChatBaseCell {
    
    static let ID = "IncomingCell"
    
    override func updateView() {
        
        super.updateView()
        
        ivAvatar.image = #imageLiteral(resourceName: "avatar.png")
        lblDate.textAlignment = .right
        if let str = viewModel?.content?.convertHtml(){
            str.addAttribute(NSAttributedStringKey.font, value: UIFont.fontWith(type: .comfortaa, size: 13), range: NSMakeRange(0, str.length))
            str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSMakeRange(0, str.length))
            DispatchQueue.main.async{
                self.tvText.attributedText = str
            }
        }
    }
    
    override func layoutView() {
        ivAvatar.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top)
            make.width.height.equalTo(30)
        }
        tvText.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-50)
            make.left.equalTo(ivAvatar.snp.right).offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        lblDate.snp.remakeConstraints { (make) in
            make.right.equalTo(tvText.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        edgeView.snp.remakeConstraints { (make) in
            make.top.equalTo(tvText.snp.top)
            make.left.equalTo(tvText.snp.left)
            make.width.height.equalTo(10)
        }
        tvText.backgroundColor = UIColor(hex: 0xF6F4FB)
        edgeView.backgroundColor = UIColor(hex: 0xF6F4FB)
    }
}
