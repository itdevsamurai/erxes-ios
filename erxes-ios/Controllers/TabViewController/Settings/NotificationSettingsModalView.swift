//
//  NotificationSettingsModalView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

protocol NotificationsDelegate: class  {
    func notificationsSaveConfig(notifType:String,isAllowed:Bool)
    func getNotificationsByEmail(isAllowed:Bool)
}

class NotificationSettingsModalView: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    var closeButton = UIButton()
    var tableView = UITableView()
    var modules = [JSON]()
    var configs = [NotificationConf]()
    var handler: (() -> Void)?
    weak var delegate: NotificationsDelegate?
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        initialize()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize() {
        
        
        
        dialogView.clipsToBounds = true
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 8
        dialogView.dropShadow(color: Constants.ERXES_COLOR!, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        
        backgroundView.frame = frame
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Email signatures"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.fontWith(type: .light, size: 15)
        titleLabel.backgroundColor = .ERXES_COLOR
        dialogView.addSubview(titleLabel)
    
        
        closeButton = UIButton()
        closeButton.semanticContentAttribute = .forceLeftToRight
        closeButton.setImage(UIImage.erxes(with: .cancel1, textColor: .TEXT_COLOR,size: CGSize(width: 14, height: 14)), for: .normal)
        closeButton.setTitle("  CLOSE", for: .normal)
        closeButton.setTitleColor(.TEXT_COLOR, for: .normal)
        closeButton.layer.cornerRadius = 20
        closeButton.backgroundColor = .white
        closeButton.layer.borderWidth = 1.0
        closeButton.layer.borderColor = UIColor.TEXT_COLOR.cgColor
        closeButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        dialogView.addSubview(closeButton)
        
        tableView = UITableView()
        tableView.register(NotificationSettingsCell.self, forCellReuseIdentifier: "NotificationSettingsCell")
        tableView.rowHeight = 40
        tableView.sectionHeaderHeight = 40
        tableView.tableFooterView = UIView()
        tableView.separatorColor = Constants.ERXES_COLOR!
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        dialogView.addSubview(tableView)
        
        
     
        
        addSubview(dialogView)
        
        dialogView.snp.makeConstraints { (make) in
            make.left.equalTo(backgroundView.snp.left).offset(20)
            make.right.equalTo(backgroundView.snp.right).inset(20)
            make.top.equalTo(backgroundView.snp.top).offset(60)
            make.height.equalTo(440)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(closeButton.snp.top).inset(-10)
        }
        
      
    }
    
    


    
    @objc func closeAction(sender: UIButton) {
        
        if let handle = handler{
            handle()
        }
        
        dismiss(animated: true)
       
    }
    
    @objc func didTappedOnBackgroundView() {
        if let handle = handler{
            handle()
        }
        dismiss(animated: true)
        
    }
    
    
}

extension NotificationSettingsModalView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}

extension NotificationSettingsModalView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return modules.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let types = modules[section]["types"] as! [JSON]
        return types.count
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width-20, height: 40))
        headerView.backgroundColor = Constants.INBOX_BG_COLOR
        let titleLabel = UILabel()
        titleLabel.frame = headerView.frame
        
        titleLabel.textColor = Constants.ERXES_COLOR!
        titleLabel.font = UIFont.fontWith(type: .light, size: 14)
        headerView.addSubview(titleLabel)
        let text = self.modules[section]["description"] as? String
        titleLabel.text = text
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSettingsCell", for: indexPath) as? NotificationSettingsCell
        let types = modules[indexPath.section]["types"] as! [JSON]
        cell?.cellDelegate = self
        cell?.desc.text = types[indexPath.row]["text"] as? String
        cell?.indexPath = indexPath
        
        if indexPath.section == 0 {
            let currentUser = ErxesUser.sharedUserInfo()
            cell?.switchControl.isOn = currentUser.getNotificationByEmail!
        }else {
            for config in configs {
                if config.notifType == types[indexPath.row]["name"] as? String {
                    cell?.switchControl.isOn = config.isAllowed!
                }
            }
        }
        return cell!
    }
    
}

extension NotificationSettingsModalView: CellDelegate {
    func didSwitchChanged(_ indexPath: IndexPath, isON: Bool) {
        let types = modules[indexPath.section]["types"] as! [JSON]
        if indexPath.section == 0 {
            delegate?.getNotificationsByEmail(isAllowed: isON)
        }else{
            let notifType = types[indexPath.row]["name"] as? String
            delegate?.notificationsSaveConfig(notifType: notifType!, isAllowed: isON)
        }
        
    }
}
