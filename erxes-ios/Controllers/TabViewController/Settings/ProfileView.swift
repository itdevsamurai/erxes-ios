//
//  ProfileView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    var user = ErxesUser() {
        didSet {
       
            for v in self.subviews {
                v.removeFromSuperview()
            }
            self.initialize(user: user,style: .type1)
        }
    }
    
   open var avatarView = UIImageView()
    
   fileprivate var backGroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(user:ErxesUser, style: ProfilewViewStyle = .type1) {
        self.init(frame: CGRect.zero)
        switch style {
        case .type1:
            self.backgroundColor = UIColor.init(hexString: "ececec")
        case .type2:
            self.backgroundColor = .white
        }
        self.user = user
        self.initialize(user: user,style: style)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func initialize(user: ErxesUser,style: ProfilewViewStyle) {
        
        avatarView.image = #imageLiteral(resourceName: "ic_avatar")
        avatarView.isUserInteractionEnabled = true
        if let url = user.avatar {
            avatarView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "ic_avatar"))
        }
        
        avatarView.clipsToBounds = true
        
        switch style {
        case .type1:
            prepareType1()
        case .type2:
            prepareType2()
        }
    }
    
    func prepareType1() {
        avatarView.layer.cornerRadius = 40
        
        let editView = UIImageView()
        editView.image = UIImage.erxes(with: .edit, textColor: .white,size: CGSize(width: 10, height: 10))
        editView.backgroundColor = .red
        editView.layer.cornerRadius = 12
        editView.clipsToBounds = true
        editView.layer.masksToBounds = true
        editView.contentMode = .scaleAspectFit
        let backGroundImage = UIImage(named: "profileBackground")
        let ratio = CGFloat((backGroundImage!.size.width)) / CGFloat((backGroundImage!.size.height))
        let imageHeight = (Constants.SCREEN_WIDTH)/ratio
        backGroundImageView = UIImageView(image: backGroundImage!)
        
        backGroundImageView.clipsToBounds = true
        backGroundImageView.contentMode = .scaleAspectFill
        self.addSubview(backGroundImageView)
        self.addSubview(avatarView)
        //            self.addSubview(editView)
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.black
        nameLabel.font = Font.bold(20)
        nameLabel.text = user.fullName
        nameLabel.textAlignment = .center
        
        self.addSubview(nameLabel)
        
        let positionLabel = UILabel()
        positionLabel.textColor = UIColor.GRAY_COLOR
        positionLabel.font = Font.regular(15)
        positionLabel.text = user.position
        positionLabel.textAlignment = .center
        positionLabel.numberOfLines = 2
        positionLabel.lineBreakMode = .byWordWrapping
        self.addSubview(positionLabel)
        self.snp.makeConstraints { (make) in
            
            make.width.equalTo(Constants.SCREEN_WIDTH)
            make.height.equalTo(imageHeight)
        }
        
        backGroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        avatarView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY).offset(-50)
            make.height.width.equalTo(80)
        }
        //            editView.snp.makeConstraints { (make) in
        //                make.width.height.equalTo(24)
        //                make.left.equalTo(avatarView.snp.right).inset(-5)
        //                make.top.equalTo(avatarView.snp.top).inset(5)
        //            }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY).offset(20)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).inset(16)
        }
        
        positionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).inset(16  )
        }
    }
    
    func prepareType2() {
        avatarView.layer.cornerRadius = 26
        self.addSubview(avatarView)
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.black
        nameLabel.font = Font.bold(15)
        nameLabel.text = user.fullName
        nameLabel.textAlignment = .left
        
        self.addSubview(nameLabel)
        
        let positionLabel = UILabel()
        positionLabel.textColor = UIColor.GRAY_COLOR
        positionLabel.font = Font.regular(13)
        positionLabel.text = user.position
        positionLabel.textAlignment = .left
        positionLabel.numberOfLines = 2
        positionLabel.lineBreakMode = .byWordWrapping
        self.addSubview(positionLabel)
        
        self.snp.makeConstraints { (make) in
            
            make.width.equalTo(Constants.SCREEN_WIDTH)
            make.height.equalTo(100)
        }
        
        avatarView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(52)
            make.left.equalTo(55)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.top)
            make.left.equalTo(avatarView.snp.right).offset(20)
            make.right.equalTo(-20)
        }
        
        positionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatarView.snp.bottom)
            make.left.equalTo(nameLabel)
            make.right.equalTo(-20)
        }
    }
    
    func scrollViewDidScroll(scrollView:UIScrollView) {
        
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        if offsetY > 0 {
            let height = self.frame.height
            backGroundImageView.frame.size.height = height + offsetY
        }
    }
}

enum ProfilewViewStyle {
    case type1
    case type2
}
