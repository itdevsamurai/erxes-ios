//
//  CustomerProfileCell.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 6/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class CustomerProfileCell: UITableViewCell {

    var titleLbl: UILabel!
    var valueLbl: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        
        self.selectionStyle = .none
        
        titleLbl = UILabel()
        titleLbl.textAlignment = .left
        titleLbl.textColor = Constants.TEXT_COLOR
        titleLbl.font = Constants.LIGHT
        contentView.addSubview(titleLbl)
        
        valueLbl = UILabel()
        valueLbl.textAlignment = .right
        valueLbl.textColor = Constants.TEXT_COLOR
        valueLbl.font = Constants.LIGHT
        contentView.addSubview(valueLbl)
   
        self.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(8)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        valueLbl.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).inset(8)
            make.height.equalTo(20)
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
