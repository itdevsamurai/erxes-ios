//
//  InboxControllerUI.swift
//  erxes-ios
//
//  Created by alternate on 11/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

class InboxControllerUI:ViewController {
    
    override func prepareView() {
        let leftItem = UIBarButtonItem()
        leftItem.customView = filterButton
        self.navigationItem.rightBarButtonItem = leftItem
        
        var rightImage = #imageLiteral(resourceName: "ic_search")
        rightImage = rightImage.withRenderingMode(.alwaysTemplate)
        let rightItem = UIBarButtonItem()
        rightItem.tintColor = UIColor.ERXES_COLOR
        rightItem.image = rightImage
        self.view.addSubview(robotView)
        robotView.isHidden = true
        
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.refreshControl = refresher
    }
    
    override func layoutView() {
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        robotView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(30)
            make.right.equalTo(self.view.snp.right).inset(30)
            make.center.equalToSuperview()
        }
        
        robotView.subviews[0].snp.makeConstraints { (make) in
            make.right.left.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(robotView.snp.bottom)
        }
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ErxesInboxCell.self, forCellReuseIdentifier: "ErxesInboxCell")
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(hexString: "#d6d6d6")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let refresher:UIRefreshControl = {
        let refresher = UIRefreshControl()
        return refresher
    }()
    
    let filterButton:UIButton = {
        let leftImage = #imageLiteral(resourceName: "ic_filter")
        let btn = UIButton()
        btn.setImage(leftImage, for: .normal)
        return btn
    }()
    
    var robotView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = #imageLiteral(resourceName: "robot-2")
        imageview.contentMode = .scaleAspectFit
        let label = UILabel()
        label.textColor = .gray
        label.font = Font.light()
        label.text = "There is no message."
        label.textAlignment = .center
        imageview.addSubview(label)
        imageview.clipsToBounds = false
        
        return imageview
    }()

}
