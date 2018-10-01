//
//  MentionController.swift
//  erxes-ios
//
//  Created by alternate on 10/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

extension ColChatController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = users[indexPath.row].details?.fullName
        return cell
    }
}

extension ColChatController {
    func queryUsers() {
        
    }
}
