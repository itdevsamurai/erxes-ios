//
//  ColCell.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/5/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ImageCell: ChatBaseCell {
    static let ID = "ImageCell"
    
    var ivAttachment:UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ivAttachment.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.left.equalToSuperview().inset(50)
        }
    }
    
    override func commonInit() {
        
        ivAttachment = UIImageView()
        ivAttachment.isUserInteractionEnabled = true
        ivAttachment.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(lblDate)
        self.contentView.addSubview(ivAttachment)
        self.contentView.addSubview(ivAvatar)
    }
    
    override func updateView() {
        super.updateView()
        
        lblDate.textAlignment = .center
        
        if let attachments = viewModel?.attachments, attachments.count > 0 {
            
            guard let attachment = attachments.first else {
                return
            }
            
            if let url = attachment!["url"] as? String {
                ivAttachment.sd_setImage(with: URL(string: url), placeholderImage:#imageLiteral(resourceName: "PlaceHolderImage"))
            }
        }
    }
    
    override func layoutView() {
        ivAvatar.snp.remakeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.top.equalTo(contentView.snp.top)
            make.width.height.equalTo(30)
        }
        lblDate.snp.remakeConstraints { (make) in
            make.left.equalTo(contentView.snp.left)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        ivAttachment.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-50)
            make.left.equalTo(ivAvatar.snp.right).offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
