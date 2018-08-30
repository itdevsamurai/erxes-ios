//
//  SettingsController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    var titles = ["Change Password","Email signatures","Notification settings","Sign Out"]
    var profileView:CustomProfileView?
    
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableview.estimatedRowHeight = 40
        tableview.contentInset = UIEdgeInsetsMake(100, 0, 0, 0 )
        tableview.tableFooterView = UIView()
//        tableview.backgroundColor = .blue
        return tableview
    }()
    
    func configureViews(){
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let currentUser = ErxesUser.sharedUserInfo()
        profileView = CustomProfileView(user: currentUser)
        profileView?.backgroundColor = Constants.INBOX_BG_COLOR
        self.view.addSubview(profileView!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS"
         self.view.backgroundColor = Constants.INBOX_BG_COLOR
        configureViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        profileView?.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.height.equalTo(100)
        }
        
    }


}

extension SettingsController: UITableViewDelegate {
    
}

extension SettingsController: UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = 100 - (scrollView.contentOffset.y + 100)
//        let height = min(max(y, 60), 200)
//        profileView?.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(topLayoutGuide.snp.bottom)
//            make.height.equalTo(height)
//        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell)!
        cell.contentView.backgroundColor = .clear
        
        cell.desc.text = titles[indexPath.row]
        cell.tintColor = Constants.ERXES_COLOR!

        return cell
    }
}
