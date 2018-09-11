//
//  UserProfileController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/1/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import Eureka
class UserProfileController: FormViewController {

    var userId: String?
    let client: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let currentUser = ErxesUser.sharedUserInfo()
        configuration.httpAdditionalHeaders = ["x-token": currentUser.token as Any,
            "x-refresh-token": currentUser.refreshToken as Any]
        let url = URL(string: Constants.API_ENDPOINT)!
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

    var loader: ErxesLoader = {
        let loader = ErxesLoader()
        loader.lineWidth = 3
        return loader
    }()

    var channels = [ChannelObject]()
    var locations = Constants.LOCATIONS
    convenience init(_id: String) {
        self.init()
        self.userId = _id
        self.getUserData(id: _id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "USER"
        self.configureViews()

    }

    func configureViews() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .clear
        let rightItem: UIBarButtonItem = {
            var rightImage = UIImage.erxes(with: .edit, textColor: UIColor.ERXES_COLOR)
            var saveImage = UIImage.erxes(with: .user2, textColor: UIColor.ERXES_COLOR)
            rightImage = rightImage.withRenderingMode(.alwaysTemplate)
            saveImage = saveImage.withRenderingMode(.alwaysTemplate)
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            button.setBackgroundImage(saveImage, for: .selected)
            button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        rightItem.tintColor = UIColor.ERXES_COLOR
        self.navigationItem.rightBarButtonItem = rightItem


        NameRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.textField.textColor = UIColor.TEXT_COLOR
        }
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.textField.textColor = UIColor.TEXT_COLOR
        }
        PhoneRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.textField.textColor = UIColor.TEXT_COLOR
        }

        EmailRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.textField.textColor = UIColor.TEXT_COLOR
        }

        DateRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR

        }

        SwitchRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.switchControl.tintColor = UIColor.ERXES_COLOR
            cell.switchControl.onTintColor = UIColor.ERXES_COLOR
        }
        IntRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.detailTextLabel?.textColor = UIColor.ERXES_COLOR
        }
        ActionSheetRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.detailTextLabel?.textColor = UIColor.ERXES_COLOR
        }
        ButtonRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.tintColor = UIColor.ERXES_COLOR
            cell.accessoryView?.tintColor = UIColor.ERXES_COLOR

        }


        DecimalRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.tintColor = UIColor.ERXES_COLOR
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)

        }



        PushRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.displayValueFor = {
                if let str = $0 {
                    return str
                }
                return nil
            }
        }

        MultipleSelectorRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.displayValueFor = {
                //                var values = Set<String>()
                if let str = $0 {
                    let arr = [String](str)
                    return arr.joined(separator: ",")
                }
                return nil
            }
        }

        TextAreaRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = .ERXES_COLOR
            cell.textView.font = UIFont.fontWith(type: .light, size: 14)
            cell.textView.textColor = .TEXT_COLOR
            cell.textView.backgroundColor = .clear
            cell.placeholderLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.placeholderLabel?.textColor = .ERXES_COLOR
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            cell.tintColor = .ERXES_COLOR
            cell.accessoryView?.tintColor = .ERXES_COLOR
        }

        SuggestionTableRow<String>.defaultCellUpdate = { cell, row in
            row.cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            row.cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.placeholder = "Type to search location"
            cell.textField.textColor = UIColor.ERXES_COLOR
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            row.filterFunction = { [unowned self] text in
                self.locations.filter({ $0.lowercased().contains(text.lowercased()) })
            }

        }

        self.view.addSubview(loader)

    }

    func getUserData(id: String) {
        loader.startAnimating()
        let query = UserDetailQuery(_id: id)
        client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
                return
            }

            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
            }

            if result?.data != nil {
                if let userData = result?.data?.userDetail {
                    self?.buildForm(user: userData)
                    self?.loader.stopAnimating()

                }

            }
        }
    }

    func buildForm(user: UserDetailQuery.Data.UserDetail) {
        form +++ Section("PROFILE") {
            $0.header?.height = { 30 }
            $0.footer = HeaderFooterView(title: "")
            $0.footer?.height = { 0 }
        }
        <<< NameRow("fullName") { row in
            row.title = "Name:"
            row.placeholder = "-"
            row.value = user.details?.fullName
        }
        <<< TextRow("username") { row in
            row.title = "Username:"
            row.placeholder = "-"
            row.value = user.username
        }
        <<< EmailRow("email") { row in
            row.title = "Email:"
            row.placeholder = "-"
            row.value = user.email

        }
        <<< TextRow("position") { row in
            row.title = "Position:"
            row.placeholder = "-"
            row.value = user.details?.position
        }
        <<< TextAreaRow("descrition") { row in
            row.title = "Description:"
            row.placeholder = "Description"
            row.value = user.details?.description

        }
        <<< SuggestionTableRow<String>("location") { row in
            row.title = "Location"
            row.value = user.details?.location
        }

            +++ Section("Links") {
                $0.footer = HeaderFooterView(title: "")
                $0.header?.height = { 30 }
                $0.footer?.height = { 0 }
        }

        <<< NameRow("linkedIn") { row in
            row.title = "linkedIn:"
            row.placeholder = "-"
            if let item = user.links?.linkedIn {
                row.value = item
            }
        }

        <<< NameRow("twitter") { row in
            row.title = "twitter:"
            row.placeholder = "-"
            if let item = user.links?.twitter {
                row.value = item
            }
        }

        <<< NameRow("facebook") { row in
            row.title = "facebook:"
            row.placeholder = "-"
            if let item = user.links?.facebook {
                row.value = item
            }
        }

        <<< NameRow("github") { row in
            row.title = "github:"
            row.placeholder = "-"
            if let item = user.links?.github {
                row.value = item
            }
        }

        <<< NameRow("youtube") { row in
            row.title = "youtube:"
            row.placeholder = "-"
            if let item = user.links?.youtube {
                row.value = item
            }
        }

        <<< NameRow("website") { row in
            row.title = "website:"
            row.placeholder = "-"
            if let item = user.links?.website {
                row.value = item
            }
        }
    }

    @objc func editAction(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            for row in form.allRows {
                row.baseCell.alpha = 0.7
                row.baseCell.isUserInteractionEnabled = false

            }
            saveAction()
        } else {
            sender.isSelected = true
            for row in form.allRows {
                row.baseCell.alpha = 1.0
                row.baseCell.isUserInteractionEnabled = true

            }
            let firstRow = form.rowBy(tag: "firstName")
            firstRow?.baseCell.cellBecomeFirstResponder()
        }
    }

    func saveAction() {
        let modalView = PasswordConfirmModalView()
        modalView.show(animated: true)
        modalView.handler = {
            let password = modalView.passwordField.textField.text
            let userName = self.form.rowBy(tag: "username")?.baseValue as? String
            let email = self.form.rowBy(tag: "email")?.baseValue as? String
            let facebook = self.form.rowBy(tag: "facebook")?.baseValue as? String
            let linkedIn = self.form.rowBy(tag: "linkedIn")?.baseValue as? String
            let github = self.form.rowBy(tag: "github")?.baseValue as? String
            let twitter = self.form.rowBy(tag: "twitter")?.baseValue as? String
            let website = self.form.rowBy(tag: "website")?.baseValue as? String
            let youtube = self.form.rowBy(tag: "youtube")?.baseValue as? String

            let mutation = UsersEditProfileMutation(username: userName!, email: email!, password: password!)
            mutation.details = UserDetails(fullName: self.form.rowBy(tag: "fullName")?.baseValue as? String, position: self.form.rowBy(tag: "position")?.baseValue as? String, location: self.form.rowBy(tag: "location")?.baseValue as? String, description: self.form.rowBy(tag: "description")?.baseValue as? String)
            mutation.links = UserLinks(linkedIn: linkedIn, twitter: twitter, facebook: facebook, youtube: youtube, github: github, website: website)
            self.client.perform(mutation: mutation) { [weak self] result, error in
                if let error = error {

                    self?.showResult(isSuccess: false, message: error.localizedDescription)
                    self?.loader.stopAnimating()
                    return
                }
                if let err = result?.errors {

                    self?.showResult(isSuccess: false, message: err[0].localizedDescription)

                    self?.loader.stopAnimating()
                }
                if result?.data != nil {
                    if (result?.data?.usersEditProfile) != nil {
                        self?.showResult(isSuccess: true, message: "Changes Saved Successfully")
                        self?.getCurrentUser()
                    }
                    self?.loader.stopAnimating()

                }
            }

        }
    }
    
    func getCurrentUser(){
        let query = CurrentUserQuery()
        client.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message:error.localizedDescription)
                alert.show(animated: true)
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message:err[0].localizedDescription)
                alert.show(animated: true)
            }
            
            if result?.data != nil {
               
                let user = result?.data?.currentUser
                let currentUser  = ErxesUser.sharedUserInfo()
                currentUser._id = user?.id
                currentUser.username = user?.username
                currentUser.email = user?.email
                currentUser.avatar = user?.details?.avatar
                currentUser.fullName = user?.details?.fullName
                currentUser.position = user?.details?.position
                currentUser.getNotificationByEmail = user?.getNotificationByEmail
     
                self?.loader.stopAnimating()
               
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }

        loader.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view.snp.center)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}



