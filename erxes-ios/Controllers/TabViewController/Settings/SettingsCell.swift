//
//  SettingsCell.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    var iconType:ErxesFont! {
        didSet {
            self.imageView?.image = UIImage.erxes(with: iconType, textColor: .black,size: CGSize(width: 20, height: 20))
        }
    }
    var desc: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        
        self.selectionStyle = .none

        
        
        desc = UILabel()
        desc.textAlignment = .left
        desc.textColor = UIColor.black
        desc.font = Font.regular(15)
        contentView.addSubview(desc)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(50)
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
