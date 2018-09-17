//
//  SettingsCell.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

   
    var desc: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        
        self.selectionStyle = .none

        
        
        desc = UILabel()
        desc.textAlignment = .left
        desc.textColor = UIColor.ERXES_COLOR
        desc.font = UIFont.fontWith(type: .light, size: 14)
        contentView.addSubview(desc)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.centerY.equalToSuperview()
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
