//
//  TextCell.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/4/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class SentCell: ChatBaseCell {
    
    static let ID = "SentCell"
    
    override func updateView() {
        
        super.updateView()
        
        guard var content = viewModel?.content else {
            return
        }
        
//        content = content.replacingOccurrences(of: "<p>", with: "")
//        content = content.replacingOccurrences(of: "</p>", with: "")
        
        let str = content.convertHtml()
        
        var options = [NSAttributedStringKey:Any]()
        options[NSAttributedStringKey.font] = Font.regular(13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 0
        options[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        
        if viewModel?.internal ?? false {
            tvText.backgroundColor = UIColor(hexString: "#fffccc")
            edgeView.backgroundColor = UIColor(hexString: "#fffccc")
            options[NSAttributedStringKey.foregroundColor] = UIColor.black
        } else {
            tvText.backgroundColor = .ERXES_COLOR
            edgeView.backgroundColor = .ERXES_COLOR
            options[NSAttributedStringKey.foregroundColor] = UIColor.white
        }
        
        
        
        str.addAttributes(options, range: NSMakeRange(0, str.length))
        
//      highlight user mentions
        let txt = content.withoutHtml

        let pattern = "@[a-zA-Z0-9._]*"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSMakeRange(0, txt.count)
        let matches = (regex?.matches(in: txt, options: [], range: range))!

        for match in matches {
            str.addAttribute(NSAttributedStringKey.font, value: Font.bold(13), range: match.range)
        }
        
        DispatchQueue.main.async{
            self.tvText.attributedText = str
            print(str.attributedSubstring(from: NSMakeRange(str.length-1, 1)).string)
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
