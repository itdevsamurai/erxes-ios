//
//  TemplateCell.swift
//  erxes-ios
//
//  Created by alternate on 11/21/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

class TemplateCell:UITableViewCell {
    static let ID = "cell"
    
    let btnSend:UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.font = Font.bold(12)
        return lbl
    }()
    
    let lblDesc:UILabel = {
        let lbl = UILabel()
        lbl.font = Font.regular(12)
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(15)
        }
        
        lblDesc.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(15)
//            make.bottom.equalToSuperview().offset(-20)
        }
        
//        btnSend.snp.makeConstraints { (make) in
//            make.top.left.equalToSuperview().offset(10)
//            make.right.equalToSuperview().offset(10)
//            make.height.equalTo(20)
//        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(btnSend)
        self.contentView.addSubview(lblTitle)
        self.contentView.addSubview(lblDesc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
