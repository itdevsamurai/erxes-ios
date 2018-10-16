//
//  NotificationSettingsCell.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

protocol CellDelegate: class {
    func didSwitchChanged(_ indexPath: IndexPath, isON:Bool)
}

class NotificationSettingsCell: UITableViewCell {
    weak var cellDelegate: CellDelegate?
    var switchControl: UISwitch!
    var desc: UILabel!
    var indexPath: IndexPath!
    required public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let switchc = UISwitch()
        switchControl = switchc
//        switchControl.onTintColor = UIColor.LIGHT_GRAY_COLOR
        switchControl.addTarget(self, action: #selector(switchChanged(sender:)), for: .valueChanged)
        switchControl.tag = self.tag
        accessoryView = switchControl
        editingAccessoryView = accessoryView
        selectionStyle = .none
        desc = UILabel()
        desc.textAlignment = .left
        desc.textColor = UIColor.black
        desc.font = Font.regular(15)
        contentView.addSubview(desc)
       
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    @objc func switchChanged(sender:UISwitch) {
        cellDelegate?.didSwitchChanged(indexPath, isON: sender.isOn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
