//
//  FilterCell.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 5/21/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    var value: UILabel!
    var desc: UILabel!
    var arrow: UIImageView!
    var countLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        
        
        self.selectionStyle = .none
        
        value = UILabel()
        value.textAlignment = .right
        value.textColor = UIColor.TEXT_COLOR
        value.font = Font.light(14)
        contentView.addSubview(value)
        
        countLabel = UILabel()
        countLabel.textAlignment = .right
        countLabel.textColor = UIColor.TEXT_COLOR
        countLabel.font = Font.light(14)
        contentView.addSubview(countLabel)
        
        
        desc = UILabel()
        desc.textAlignment = .left
        desc.textColor = UIColor.TEXT_COLOR
        desc.font = Font.light(14)
        contentView.addSubview(desc)
        
        arrow = UIImageView()
        arrow.image = #imageLiteral(resourceName: "ic_rightArrow")
        arrow.image = arrow.image!.withRenderingMode(.alwaysTemplate)
        arrow.tintColor = UIColor.TEXT_COLOR
        contentView.addSubview(arrow)
        self.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.height.equalTo(20)
        }
        
        arrow.snp.makeConstraints { (make) in
            make.height.width.equalTo(22)
            make.right.equalTo(contentView.snp.right).inset(10)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        value.snp.makeConstraints { (make) in
            make.left.equalTo(desc.snp.right).offset(10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.equalTo(contentView.snp.right).inset(35)
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
