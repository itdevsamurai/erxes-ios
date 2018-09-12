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
        
        if let str = viewModel?.content?.convertHtml(){
            str.addAttribute(NSAttributedStringKey.font, value: Constants.REGULAR, range: NSMakeRange(0, str.length))
            str.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSMakeRange(0, str.length))
            tvText.attributedText = str
        }
    }
    
    override func layoutView() {
        ivAvatar.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top)
            make.width.height.equalTo(30)
        }
        lblDate.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(45)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        tvText.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-50)
            make.left.equalTo(ivAvatar.snp.right).offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        edgeView.snp.remakeConstraints { (make) in
            make.top.equalTo(tvText.snp.top)
            make.left.equalTo(tvText.snp.left)
            make.width.height.equalTo(10)
        }
        tvText.backgroundColor = Constants.LIGHT_GRAY_COLOR
        edgeView.backgroundColor = Constants.LIGHT_GRAY_COLOR
    }
}
