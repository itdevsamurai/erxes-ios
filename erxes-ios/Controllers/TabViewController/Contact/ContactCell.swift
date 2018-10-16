//
//  ContactCell.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/13/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {


    var topLabel: UILabel!
    var bottomLabel: UILabel!
    var icon: UIImageView!
    var taglistView: ErxesTagView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        
        
        self.selectionStyle = .none
        
        topLabel = UILabel()
        topLabel.textAlignment = .right
        topLabel.textColor = UIColor.black
        topLabel.font = Font.regular(14)
        contentView.addSubview(topLabel)
        
        bottomLabel = UILabel()
        bottomLabel.textAlignment = .right
        bottomLabel.textColor = UIColor.LIGHT_GRAY_COLOR
        bottomLabel.font = Font.regular(14)
        contentView.addSubview(bottomLabel)
        
    
        
        icon = UIImageView()
        
//        icon.image = icon.image!.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.ERXES_COLOR
        icon.image = #imageLiteral(resourceName: "ic_avatar")
        contentView.addSubview(icon)
        
        taglistView = ErxesTagView()
        taglistView.clipsToBounds = true
        contentView.addSubview(taglistView)
//        self.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).inset(10)
            make.width.height.equalTo(50)
            make.centerY.equalTo(contentView.snp.centerY)
            
        }
        
        topLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.equalTo(icon.snp.top)
//            make.height.equalTo(20)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(10)
            make.centerY.equalToSuperview()
            //            make.height.equalTo(20)
        }
        
        taglistView.snp.makeConstraints { (make) in
            make.left.equalTo(topLabel.snp.left)
            make.right.equalTo(contentView.snp.right).inset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(5)
            make.height.equalTo(18)
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
