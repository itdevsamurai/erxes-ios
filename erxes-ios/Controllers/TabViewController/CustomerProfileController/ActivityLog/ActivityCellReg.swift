//
//  ActivityCellReg.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/11/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ActivityCellReg: UITableViewCell {

    var avatarView: UIImageView!
    var descLabel: UILabel!
    var dateLabel: UILabel!
    var iconView: UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        avatarView = UIImageView()
        avatarView.image = UIImage(named: "ic_avatar")
        avatarView.layer.cornerRadius = 25
        avatarView.clipsToBounds = true
        dateLabel = UILabel()
        dateLabel.textColor = .GRAY_COLOR
        dateLabel.font = Font.regular(8)
        dateLabel.textAlignment = .right
        
        descLabel = UILabel ()
        descLabel.textColor = .black
        descLabel.font = Font.regular(14)
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 2
        descLabel.lineBreakMode = .byWordWrapping
        
        iconView = UIImageView()
        iconView.contentMode = .center
        iconView.layer.cornerRadius = 10
        iconView.clipsToBounds = true
        iconView.backgroundColor = .ERXES_COLOR
        iconView.image = UIImage.erxes(with: .adduser, textColor: .white, size: CGSize(width: 14, height: 14))
        
        contentView.addSubview(avatarView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(iconView)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.contentView.snp.right).inset(16)
        }
        

        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarView.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).inset(16)
            make.top.equalTo(avatarView.snp.top).offset(5)
            make.bottom.equalTo(avatarView.snp.bottom).inset(5)
        }
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(avatarView.snp.right).inset(15)
            make.top.equalTo(avatarView.snp.bottom).inset(15)
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
