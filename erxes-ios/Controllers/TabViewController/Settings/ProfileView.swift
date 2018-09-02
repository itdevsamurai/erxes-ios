//
//  ProfileView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    var user = ErxesUser() {
        didSet{
            for v in self.subviews{
                v.removeFromSuperview()
            }
            self.initialize(user: user)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(user:ErxesUser) {
        self.init(frame: CGRect.zero)
        
        self.initialize(user: user)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func initialize(user: ErxesUser) {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "avatar.png")
        if let url = user.avatar {
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "avatar.png"))
        }
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        self.addSubview(imageView)
      
        let nameLabel = UILabel()
        nameLabel.textColor = Constants.TEXT_COLOR
        nameLabel.font = UIFont.fontWith(type: .light, size: 16)
        nameLabel.text = user.fullName
        nameLabel.textAlignment = .left
        
        
        self.addSubview(nameLabel)
        
        let positionLabel = UILabel()
        positionLabel.textColor = .TEXT_COLOR
        positionLabel.font = UIFont.fontWith(type: .light, size: 16)
        positionLabel.text = user.position
        positionLabel.textAlignment = .left
        positionLabel.numberOfLines = 2
        positionLabel.lineBreakMode = .byWordWrapping
        self.addSubview(positionLabel)
        
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(80)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top)
            make.right.equalTo(self.snp.right).inset(10)
            make.left.equalTo(imageView.snp.right).offset(10)
            
        }
        
        positionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(imageView.snp.bottom)
            make.right.equalTo(self.snp.right).inset(10)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(nameLabel.snp.bottom)
        }
        
    }
}
