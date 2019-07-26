//
//  UserProfileController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/1/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit
import Apollo
import Eureka
class UserProfileController: FormViewController {

    var userId: String?

    var channels = [ChannelObject]()
    var locations = Constants.LOCATIONS
    convenience init(_id: String) {
        self.init()
        self.userId = _id
        self.getUserData(id: _id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.form.removeAll()
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
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            button.setBackgroundImage(rightImage, for: .normal)
            button.setBackgroundImage(saveImage, for: .selected)
            button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        rightItem.tintColor = UIColor.ERXES_COLOR
        self.navigationItem.rightBarButtonItem = rightItem
        
        setStandartRowStyles()
        setSpecialRowStyles()
    }
    
    func setStandartRowStyles() {
        NameRow.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        TextRow.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        PhoneRow.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        
        EmailRow.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        
        DateRow.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        
        SwitchRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.switchControl.tintColor = UIColor.ERXES_COLOR
            cell.switchControl.onTintColor = UIColor.ERXES_COLOR
        }
        IntRow.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        ActionSheetRow<String>.defaultCellUpdate = { cell, row in
            self.setCellStyle(cell)
        }
        ButtonRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.tintColor = UIColor.ERXES_COLOR
            cell.accessoryView?.tintColor = UIColor.ERXES_COLOR
        }
        
        DecimalRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.tintColor = UIColor.ERXES_COLOR
            cell.textField.font = Font.light(14)
        }
    }
    
    func setSpecialRowStyles() {
        PushRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.displayValueFor = {
                if let str = $0 {
                    return str
                }
                return nil
            }
        }
        
        MultipleSelectorRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
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
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = .ERXES_COLOR
            cell.textView.font = Font.light(14)
            cell.textView.textColor = .TEXT_COLOR
            cell.textView.backgroundColor = .clear
            cell.placeholderLabel?.font = Font.light(14)
            cell.placeholderLabel?.textColor = .ERXES_COLOR
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            cell.tintColor = .ERXES_COLOR
            cell.accessoryView?.tintColor = .ERXES_COLOR
        }
        
        SuggestionTableRow<String>.defaultCellUpdate = { cell, row in
            row.cell.textLabel?.font = Font.light(14)
            row.cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.placeholder = "Type to search location"
            cell.textField.textColor = UIColor.ERXES_COLOR
            cell.textField.font = Font.light(14)
            cell.detailTextLabel?.font = Font.light(14)
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            row.filterFunction = { [unowned self] text in
                self.locations.filter({ $0.lowercased().contains(text.lowercased()) })
            }
        }
    }
    
    func setCellStyle(_ cell:UITableViewCell) {
        cell.textLabel?.font = Font.light(14)
        cell.textLabel?.textColor = UIColor.ERXES_COLOR
        
        cell.detailTextLabel?.textColor = UIColor.ERXES_COLOR
        cell.detailTextLabel?.font = Font.light(14)
        
        if let fieldCell = cell as? _FieldCell<String> {
            fieldCell.textField.font = Font.light(14)
            fieldCell.textField.textColor = UIColor.TEXT_COLOR
        }
    }

    func getUserData(id: String) {
        
        let query = UserDetailQuery(_id: id)
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
                if let userData = result?.data?.userDetail {
                    self?.buildForm(user: userData)
                    

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
        <<< TextAreaRow("desc") { row in
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

            self.presentTextFieldAlert(title: "Confirm", msg: "Enter your password to confirm") { (textValue) in
                print(textValue)
                self.saveAction(userPassword: textValue!)
            }
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

    func saveAction(userPassword:String) {
    
            
            let userName = self.form.rowBy(tag: "username")?.baseValue as? String
            let email = self.form.rowBy(tag: "email")?.baseValue as? String
            let facebook = self.form.rowBy(tag: "facebook")?.baseValue as? String
            let linkedIn = self.form.rowBy(tag: "linkedIn")?.baseValue as? String
            let github = self.form.rowBy(tag: "github")?.baseValue as? String
            let twitter = self.form.rowBy(tag: "twitter")?.baseValue as? String
            let website = self.form.rowBy(tag: "website")?.baseValue as? String
            let youtube = self.form.rowBy(tag: "youtube")?.baseValue as? String

            let mutation = UsersEditProfileMutation(username: userName!, email: email!, password: userPassword)
        mutation.details = UserDetails(avatar: ErxesUser.sharedUserInfo().avatar,fullName: self.form.rowBy(tag: "fullName")?.baseValue as? String, position: self.form.rowBy(tag: "position")?.baseValue as? String, location: self.form.rowBy(tag: "location")?.baseValue as? String, description: self.form.rowBy(tag: "desc")?.baseValue as? String)
            mutation.links = UserLinks(linkedIn: linkedIn, twitter: twitter, facebook: facebook, youtube: youtube, github: github, website: website)
            appnet.perform(mutation: mutation) { [weak self] result, error in
                if let error = error {

                    self?.showResult(isSuccess: false, message: error.localizedDescription,resultCompletion: nil)

                    return
                }
                if let err = result?.errors {

                    self?.showResult(isSuccess: false, message: err[0].localizedDescription,resultCompletion: nil)

                }
                if result?.data != nil {
                    if (result?.data?.usersEditProfile) != nil {
                        self?.showResult(isSuccess: true, message: "Changes Saved Successfully",resultCompletion: {
                            self?.navigationController?.popViewController(animated: true)
                        })

                    }


                }
            }

        
    }
    
    func getCurrentUser() {
        let query = CurrentUserQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData) { [weak self] result, error in
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
     
                
               
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}



