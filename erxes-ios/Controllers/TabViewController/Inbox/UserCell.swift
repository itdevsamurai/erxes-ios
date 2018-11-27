//
//  UserCell.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/19/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    var fullName: UILabel!
    var avatar: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        
        self.selectionStyle = .none
        
        avatar = UIImageView()
        //        tagView.image = #imageLiteral(resourceName: "ic_tag")
        avatar.layer.cornerRadius = 17
        avatar.clipsToBounds = true
        contentView.addSubview(avatar)
        
        fullName = UILabel()
        fullName.textAlignment = .left
        fullName.textColor = UIColor.TEXT_COLOR
        fullName.font = Font.light(14)
        contentView.addSubview(fullName)

        self.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatar.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.width.equalTo(34)
        }
        
        fullName.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(20)
        }

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
