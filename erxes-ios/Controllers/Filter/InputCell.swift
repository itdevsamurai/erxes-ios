//
//  InputCell.swift
//  erxes-ios
//
//  Created by alternate on 9/26/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

class InputCell:UITableViewCell {
    
    static let ID = "InputCell"
    
    public var input:UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        input.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(50)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        input = UITextField()
        input.placeholder = "Search..."
        input.font = UIFont.fontWith(type: .comfortaa, size: 13)
        input.textColor = UIColor(hexString: "#1f9fe2")
        contentView.addSubview(input)
    }
}
