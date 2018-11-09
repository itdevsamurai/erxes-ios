//
//  ConversationsController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/10/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class ConversationsController: UIViewController {

    var conversations = [LogData]() {
        didSet{
            for (index, conversation) in conversations.enumerated() {
            
                let filtered = conversation.list.filter({$0?.action == "conversation-create"})
                self.conversations[index].list = filtered
             
            }
            self.conversations = self.conversations.filter({$0.list.count != 0})
            tableView.reloadData()
        }
    }
    
    var contactName = String()
    var contactId = String()
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ActivityCellCon.self, forCellReuseIdentifier: "ActivityCellCon")
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor.LIGHT_GRAY_COLOR
        
        return tableView
    }()
    
    convenience init(id:String, name:String) {
        self.init()
        contactId = id
        contactName = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}


extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = conversations[indexPath.section].list[indexPath.row]
        self.navigate(.chat(withId: (data?.id)!, title: "", customerId: self.contactId))
        
        
    }
}

extension ConversationsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.conversations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.conversations[section].list.count)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 40))
        headerView.backgroundColor = UIColor.init(hexString: "ebebeb")
        let iconView = UIImageView(frame: CGRect(x: 16, y: 9, width: 20, height: 20))
        iconView.image = UIImage.erxes(with: .calendar, textColor: .LIGHT_GRAY_COLOR)
        iconView.contentMode = .scaleAspectFit
        headerView.addSubview(iconView)
        let label = UILabel(frame: CGRect(x: 48, y: 0, width: Constants.SCREEN_WIDTH-64, height: 40))
        label.textColor = .black
        label.font = Font.regular(14)
        let date = conversations[section].date
        let monthName = DateFormatter().monthSymbols![(date.month)!]
        label.text = String(format: "%@ %i", monthName, (date.year)!)
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = conversations[indexPath.section].list[indexPath.row]
        let date = data?.createdAt.dateFromUnixTime()
        let now = Date()
        let dateLblValue = Utils.getTimeComponentString(olderDate: date!, newerDate: now)

            if let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCellCon", for: indexPath) as? ActivityCellCon {
                cell.dateLabel.text = dateLblValue
                cell.messageLabel.text = data?.content
                cell.descLabel.text  = contactName + " sent a conversation message"
                cell.iconView.image = UIImage.erxes(with: .speechbubble3, textColor: .white, size: CGSize(width: 12, height: 12))
                cell.iconView.backgroundColor = UIColor.init(hexString: "f54038")
                return cell
            }
        
        
        return UITableViewCell()
    }
}
