//
//  ErxesInboxCell.swift
//  Erxes.io
//
//  Created by soyombo bat-erdene on 2/16/18.
//  Copyright © 1618 soyombo bat-erdene. All rights reserved.
//

import UIKit
import SnapKit

class ErxesInboxCell: UITableViewCell {

    var message: ErxesLabel!
    var date: ErxesLabel!
    var avatar: UIImageView!
    var fullName: ErxesLabel!
    var desc: ErxesLabel!
    var tagListView: TagListView!
    var circleView: UIView!
    var iconView: UIImageView!
    var userAvatar: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        avatar = UIImageView()
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        avatar.backgroundColor = UIColor.SHIMMER_COLOR
        contentView.addSubview(avatar)


        fullName = ErxesLabel()
        fullName.textAlignment = .left
        fullName.font = Font.regular(13)
        fullName.textColor = UIColor(hexString: "#232323")
        fullName.backgroundColor = .SHIMMER_COLOR
        contentView.addSubview(fullName)


        desc = ErxesLabel()
//        desc.textAlignment = .right
        desc.font = Font.regular(10)
        desc.textColor = UIColor(hexString: "#232323", alpha:0.5)
        desc.minimumScaleFactor = 0.5
        desc.adjustsFontSizeToFitWidth = true
        desc.backgroundColor = .SHIMMER_COLOR
        contentView.addSubview(desc)


        date = ErxesLabel()
        date.font = Font.regular(8)
        date.textAlignment = .right
        date.textColor = .gray
        date.numberOfLines = 0
        date.lineBreakMode = .byCharWrapping
        date.backgroundColor = .SHIMMER_COLOR
        date.font = date.font.withSize(10)
        contentView.addSubview(date)



        message = ErxesLabel()
        message.textAlignment = .left
        message.textColor = UIColor(hexString: "#232323", alpha:0.5)
        message.font = Font.regular(13)
        message.numberOfLines = 1
        message.minimumScaleFactor = 0.5
        message.backgroundColor = UIColor.LIGHT_GRAY_COLOR
        message.lineBreakMode = .byTruncatingTail
        contentView.addSubview(message)


        tagListView = TagListView()
        tagListView.tagBackgroundColor = UIColor.ERXES_COLOR
        tagListView.cornerRadius = 5.0
        tagListView.textFont = Font.light(8)
        tagListView.textColor = .white
        tagListView.clipsToBounds = false

        contentView.addSubview(tagListView)


        circleView = UIView()
        circleView.layer.cornerRadius = 13
        circleView.clipsToBounds = true
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 0.7
        contentView.addSubview(circleView)
        
        iconView = UIImageView()
        iconView.layer.cornerRadius = 7
        iconView.clipsToBounds = true
        circleView.addSubview(iconView)
        
        userAvatar = UIImageView()
        userAvatar.layer.cornerRadius = 10
        userAvatar.clipsToBounds = true
        contentView.addSubview(userAvatar)
    }

    func clearColor() {
        message.backgroundColor = .clear
        date.backgroundColor = .clear
        desc.backgroundColor = .clear
        fullName.backgroundColor = .clear
        avatar.backgroundColor = UIColor.ERXES_COLOR

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.width.height.equalTo(50)
        }
        fullName.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(15)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.height.equalTo(13)

        }
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(15)
            make.right.equalTo(contentView.snp.right).inset(10)
            make.top.equalTo(fullName.snp.bottom).offset(7)
            make.height.equalTo(10)
        }
        message.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(15)
            make.right.equalTo(contentView.snp.right).inset(100)
            make.top.equalTo(desc.snp.bottom).offset(7)
            make.height.equalTo(13)
        }
        date.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).inset(10)
            make.top.equalTo(contentView.snp.top).inset(20)
            make.height.equalTo(16)
            make.left.equalTo(fullName.snp.left).offset(10)
        }

        tagListView.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(15)
            make.right.equalTo(contentView.snp.right).inset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(6)
            make.height.equalTo(20)
        }
        
        circleView.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).inset(15)
            make.top.equalTo(avatar.snp.bottom).inset(15)
            make.width.height.equalTo(26)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        userAvatar.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).inset(10)
            make.width.height.equalTo(20)
            make.top.equalTo(message.snp.top)
            
        }

        self.separatorInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
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

    func setIcon(type: integrationKind) {
        switch type {
        case .messenger:
//            iconView.image = #imageLiteral(resourceName: "messenger")
            iconView.image = UIImage.erxes(with: .facebookmessengerlogo, textColor: UIColor.FB_COLOR)
            circleView.backgroundColor = UIColor.FB_COLOR
            iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
            
        case .form:
            iconView.image = UIImage.erxes(with: .file, textColor: UIColor.white)
            circleView.backgroundColor =   UIColor.init(hexString: "f8cf5f")
            iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        case .feed:
            iconView.image = UIImage.erxes(with: .facebooklogo, textColor: UIColor.FB_COLOR)
            circleView.backgroundColor = UIColor.FB_COLOR
            iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        case .user:
            iconView.image = UIImage.erxes(with: .chat, textColor: UIColor.ERXES_COLOR)
            circleView.backgroundColor = UIColor.ERXES_COLOR
            iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
            avatar.backgroundColor =  UIColor.init(hexString: "60d2d6")
            
        case .notuser:
//            iconView.image = #imageLiteral(resourceName: "user")
            iconView.image = UIImage.erxes(with: .speechbubble2, textColor: UIColor.ERXES_COLOR)
            circleView.backgroundColor = UIColor.ERXES_COLOR
            iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
           
        case .twitter:
            iconView.image = UIImage.erxes(with: .twitterlogo, textColor: UIColor.ERXES_COLOR)
            circleView.backgroundColor = UIColor.init(hexString: "139fef")
            iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        }
        iconView.tintColor = .white
    }

}

enum integrationKind {
    case messenger
    case form
    case feed
    case user
    case notuser
    case twitter
}
