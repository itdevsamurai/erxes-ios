//
//  InComingCell.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/11/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class IncomingCell: ChatBaseCell {
    
    static let ID = "IncomingCell"
    
    override func updateView() {
        
        super.updateView()
        
        ivAvatar.image = #imageLiteral(resourceName: "ic_avatar")
        lblDate.textAlignment = .right
        
        guard let content = viewModel?.content else {
            return
        }
        
        let str = content.convertHtml()
        
        var options = [NSAttributedStringKey:Any]()
        options[NSAttributedStringKey.font] = Font.regular(13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 0
        options[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        options[NSAttributedStringKey.foregroundColor] = UIColor.black
        
        str.addAttributes(options, range: NSMakeRange(0, str.length))
        
        DispatchQueue.main.async{
            self.tvText.attributedText = str
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
