//
//  NotificationSettingsController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

protocol NotificationsDelegate: class {
    func notificationsSaveConfig(notifType: String, isAllowed: Bool)
    func getNotificationsByEmail(isAllowed: Bool)
}

class NotificationSettingsController: UIViewController {



    var profileView: ProfileView?
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(NotificationSettingsCell.self, forCellReuseIdentifier: "NotificationSettingsCell")
        tableview.rowHeight = 47
        tableview.sectionHeaderHeight = 47
        tableview.tableFooterView = UIView()
        tableview.separatorColor = UIColor.GRAY_COLOR
        tableview.backgroundColor = .white
        return tableview
    }()
    var modules = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    var configs = [NotificationConf]() {
        didSet {
            tableView.reloadData()
        }
    }
    weak var delegate: NotificationsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.getNotificationsData()
    }

    func configureViews() {
        self.title = "Notification settings"
        self.view.backgroundColor = .white
        let currentUser = ErxesUser.sharedUserInfo()
        profileView = ProfileView(user: currentUser, style: .type2)
        self.view.addSubview(profileView!)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(100)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        })

        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo((profileView?.snp.bottom)!)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }

    func setIcon(description: String) -> ErxesFont {
        switch description {
        case "Get notification by email":
            return ErxesFont.email3
        case "State change":
            return ErxesFont.alarm
        case "Assignee change":
            return ErxesFont.user
        case "Add message":
            return ErxesFont.email
        case "Members change":
            return ErxesFont.users
        default:
            return ErxesFont.alarm
        }
    }

    func getNotificationsData() {

        let query = NotificationsModulesQuery()
        let query1 = NotificationsGetConfigurationsQuery()
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)

                return
            }

            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)

            }

            if result?.data != nil {
                if let modules = result?.data?.notificationsModules {
                    self?.modules = modules as! [JSON]

                    let firstItem: JSON = ["description": "NOTIFICATIONS ", "name": "notifications ", "types": [["name": "usersConfigGetNotificationByEmail", "text": "Get notification by email"]]]
                    self?.modules.insert(firstItem, at: 0)


                }

            }
        }

        appnet.fetch(query: query1, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)

                return
            }

            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)

            }

            if result?.data != nil {
                if let configs = result?.data?.notificationsGetConfigurations {
                    self?.configs = configs.map { ($0?.fragments.notificationConf)! }

                }
            }
        }
    }

    func getNotificationByEmailMutation(isAllowed: Bool) {
        let mutation = UsersConfigGetNotificationByEmailMutation(isAllowed: isAllowed)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {

                self?.showResult(isSuccess: false, message: error.localizedDescription,resultCompletion: nil)

                return
            }
            if let err = result?.errors {

                self?.showResult(isSuccess: false, message: err[0].localizedDescription,resultCompletion: nil)


            }
            if result?.data != nil {
                if (result?.data?.usersConfigGetNotificationByEmail) != nil {
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully",resultCompletion: nil)
                }

            }
        }
    }

    func notificationsSaveConfigMutation(notifType: String, isAllowed: Bool) {
        let mutation = NotificationsSaveConfigMutation(notifType: notifType, isAllowed: isAllowed)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {

                self?.showResult(isSuccess: false, message: error.localizedDescription,resultCompletion: nil)

                return
            }
            if let err = result?.errors {

                self?.showResult(isSuccess: false, message: err[0].localizedDescription,resultCompletion: nil)


            }
            if result?.data != nil {
                if (result?.data?.notificationsSaveConfig) != nil {
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully",resultCompletion: nil)
                }

            }
        }
    }


}

extension NotificationSettingsController: UITableViewDelegate {

}

extension NotificationSettingsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return modules.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let types = modules[section]["types"] as! [JSON]
        return types.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: 40))
        headerView.backgroundColor = UIColor.init(hexString: "ebebeb")
        let titleLabel = UILabel()
        titleLabel.frame = headerView.frame
        titleLabel.frame.origin.y = titleLabel.frame.origin.y + 5
        titleLabel.textColor = UIColor.black
        titleLabel.font = Font.regular(15)
        headerView.addSubview(titleLabel)
        let text = self.modules[section]["description"] as? String
        titleLabel.text = text?.uppercased()
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSettingsCell", for: indexPath) as? NotificationSettingsCell
        let types = modules[indexPath.section]["types"] as! [JSON]
        cell?.cellDelegate = self
        let desc = types[indexPath.row]["text"] as? String
        cell?.desc.text = desc
        cell?.imageView?.image = UIImage.erxes(with: self.setIcon(description: desc!), textColor: .black)
        cell?.indexPath = indexPath

        if indexPath.section == 0 {
            let currentUser = ErxesUser.sharedUserInfo()
            cell?.switchControl.isOn = currentUser.getNotificationByEmail!
        } else {
            for config in configs {
                if config.notifType == types[indexPath.row]["name"] as? String {
                    cell?.switchControl.isOn = config.isAllowed!
                }
            }
        }
        return cell!
    }
}

extension NotificationSettingsController: CellDelegate {
    func didSwitchChanged(_ indexPath: IndexPath, isON: Bool) {
        let types = modules[indexPath.section]["types"] as! [JSON]
        if indexPath.section == 0 {
            self.getNotificationByEmailMutation(isAllowed: isON)
        } else {
            if let notifType = types[indexPath.row]["name"] as? String {
                self.notificationsSaveConfigMutation(notifType: notifType, isAllowed: isON)
            }

        }

    }
}
