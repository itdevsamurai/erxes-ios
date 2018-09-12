//
//  CustomerProfileController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 6/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import Eureka

class CustomerProfileController: FormViewController {

//    var profileFields = ["String"]()
    var profileField = FieldGroup(id: "profile")

    var customerId: String?
    var messagesCount = 0
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

    var companies = [CompanyDetail]() {
        didSet {

        }
    }

    var fieldGroups = [FieldGroup]()

    var users = [UserData]() {
        didSet {

        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customer"

        self.configureViews()
        self.getFields()
        self.getCustomerData()
        self.getCompanies()
        self.getUsers()

        // Do any additional setup after loading the view.
    }


    func getFields() {
        loader.startAnimating()



        let query = FieldsGroupsQuery(contentType: "customer")
        client.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                if let resultData = result?.data?.fieldsGroups {
                    self?.fieldGroups = resultData.map { ($0?.fragments.fieldGroup)! }
                    self?.loader.stopAnimating()
                    self?.profileField.isVisible = true
                    self?.profileField.name = "PROFILE"
                    self?.profileField.order = -1
//                    self?.profileField.fields = [field]
                    var fieldsArray = [FieldGroup.Field]()

                    if let path = Bundle.main.path(forResource: "Profile", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                            if let jsonResult = jsonResult as? [[String: Any]] {
                                for (index, json) in jsonResult.enumerated() {
                                    var field = FieldGroup.Field(snapshot: ["": ""])
                                    field.id = json["id"] as! String
                                    field.text = json["text"] as? String
                                    field.type = json["type"] as? String
                                    field.validation = json["validation"] as? String
                                    field.options = json["options"] as! [String]
                                    field.order = index
                                    field.isVisible = true
                                    fieldsArray.append(field)
                                }
                            }
                        } catch {
                            // handle error
                        }
                    }
                    self?.profileField.fields = fieldsArray

                    self?.fieldGroups.insert((self?.profileField)!, at: 0)

                }
            }
        }

    }

    func getCustomerData() {
        loader.startAnimating()
        let query = CustomerDetailQuery(_id: self.customerId!)
        client.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                if let result = result?.data?.customerDetail?.fragments.customerInfo {
                    self?.buildForm(customer: result)

                    self?.loader.stopAnimating()

                }
            }
        }
    }

    func buildForm(customer: CustomerInfo) {
        
        let obj = Mirror(reflecting: customer)
        var profile = [String: Any]()
        var customFields = [String: Any]()
        print(customer)
        for case let (label?, value) in obj.children {
            let c = value as! [String: Any]
            profile = c

            if let tmp = profile["customFieldsData"] as? [String: Any] {
                customFields = tmp
            }

        }

        for group in fieldGroups {
            if group.isVisible! {
                form +++ Section(group.name!)
                let sorted = group.fields?.sorted { obj1, obj2 in
                    (obj1?.order)! < (obj2?.order)!
                }
                if group.order == -1 {
                    for field in sorted! {
                        if (field?.isVisible)! {
                            if field?.type == "firstName" || field?.type == "lastName" {
                                form.last!
                                <<< NameRow (field?.id) { row in
                                    row.title = field?.text
                                    row.value = profile[(field?.id)!] as? String

                                }
                            } else if field?.type == "input" && (field?.validation?.isEmpty)! {
                                form.last!
                                <<< TextRow (field?.id) { row in
                                    row.title = field?.text
                                    row.value = profile[(field?.id)!] as? String
                                }
                            } else if field?.type == "input" && field?.validation == "number" {
                                form.last!
                                <<< TextRow (field?.id) { row in
                                    row.title = field?.text
                                    row.value = profile[(field?.id)!] as? String

                                }.cellSetup({ (cell, lrow) in
                                    cell.textField.keyboardType = .numberPad
                                })
                            } else if field?.type == "input" && field?.validation == "date" {
                                form.last!
                                <<< DateRow (field?.id) { row in
                                    row.title = field?.text
                                    row.value = profile[(field?.id)!] as? Date
                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                })

                            } else if field?.type == "select" {
                                form.last!
                                <<< PushRow<String> (field?.id) { row in
                                    row.title = field?.text
                                    row.options = field?.options as? [String]
                                    row.value = profile[(field?.id)!] as? String
                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                }).onPresent { from, to in
                                    to.selectableRowCellUpdate = { cell, row in
                                        
                                        cell.textLabel!.font = UIFont.fontWith(type: .light, size: 14   )
                                        cell.textLabel!.textColor = UIColor.TEXT_COLOR
                                    }
                                }
                            } else if field?.type == "check" && field?.options == ["on", "off"] {
                                form.last!
                                <<< SwitchRow(field?.id) { row in
                                    row.title = field?.text
                                    let state = profile[(field?.id)!] as? String

                                    if state == "Yes" {
                                        row.value = true
                                    } else {
                                        row.value = false
                                    }

                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                })
                            } else if field?.type == "check" {
                                form.last!
                                <<< MultipleSelectorRow<String>(field?.id) { row in
                                    row.title = field?.text
                                    row.options = field?.options as? [String]
//                                        row.value = profile[(field?.id)!] as? Set<String>
                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                }).onPresent { from, to in
                                    to.selectableRowCellUpdate = { cell, row in
                                        
                                        cell.textLabel!.font = UIFont.fontWith(type: .light, size: 14   )
                                        cell.textLabel!.textColor = UIColor.TEXT_COLOR
                                    }
                                }
                            } else if field?.validation == "email" {
                                form.last!
                                <<< EmailRow(field?.id) { row in
                                    row.title = field?.text
                                    row.value = profile[(field?.id)!] as? String
                                }
                            }
                            
                           
                           
                        }
                    }
                } else {

                    for field in sorted! {
                        if (field?.isVisible)! {
                            if field?.type == "firstName" || field?.type == "lastName" {
                                form.last!
                                <<< NameRow (field?.id) { row in
                                    row.title = field?.text
                                    row.value = customFields[(field?.id)!] as? String

                                }
                            } else if field?.type == "input" && (field?.validation?.isEmpty)! {
                                form.last!
                                <<< TextRow (field?.id) { row in
                                    row.title = field?.text
                                    row.value = customFields[(field?.id)!] as? String
                                }
                            } else if field?.type == "input" && field?.validation == "number" {
                                form.last!
                                <<< TextRow (field?.id) { row in

                                    row.title = field?.text
                                    row.value = customFields[(field?.id)!] as? String
                                }.cellSetup({ (cell, lrow) in
                                    cell.textField.keyboardType = .numberPad
                                })
                            } else if field?.type == "input" && field?.validation == "date" {
                                form.last!
                                <<< DateRow (field?.id) { row in
                                    row.title = field?.text
                                    let stringDate = customFields[(field?.id)!] as? String
                                    if (stringDate != nil) {
                                        row.value = stringDate?.dateFromString()
                                    }

                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                })
                            } else if field?.type == "select" {
                                form.last!
                                <<< PushRow<String> (field?.id) { row in
                                    row.title = field?.text
                                    row.options = field?.options as? [String]
                                    row.value = customFields[(field?.id)!] as? String
                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                })
                            } else if field?.type == "check" && field?.options == ["on", "off"] {
                                form.last!
                                <<< SwitchRow(field?.id) { row in
                                    row.title = field?.text

                                    let state = customFields[(field?.id)!] as? String
                                    if state == "Yes" {
                                        row.value = true
                                    } else {
                                        row.value = false
                                    }
                                }.cellSetup({ (cell, lrow) in
                                    cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                    cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                })
                            } else if field?.type == "check" {
                                form.last!
                                <<< MultipleSelectorRow<String>(field?.id) { row in
                                    row.title = field?.text
                                    row.options = field?.options as? [String]

                                    if let array = customFields[(field?.id)!] as? [String] {
                                        if array.count != 0 {
                                            let objectSet = Set(array.map { $0 })
                                            row.value = objectSet
                                        }
                                    }
                                    }.cellSetup({ (cell, lrow) in
                                        cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                        cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                    })
                                } else if field?.validation == "email" {
                                    form.last!
                                    <<< EmailRow(field?.id) { row in
                                        row.title = field?.text
                                        row.value = customFields[(field?.id)!] as? String
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for row in form.allRows {
                row.baseCell.alpha = 0.7
                row.baseCell.isUserInteractionEnabled = false

            }
        }




        func getCompanies() {
            loader.startAnimating()

            let query = CompaniesQuery()
            client.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                    if let allCompanies = result?.data?.companies {

                        self?.companies = allCompanies.map { ($0?.fragments.companyDetail)! }

                        self?.loader.stopAnimating()


                    }
                }
            }

        }

        func getUsers() {
            loader.startAnimating()
            let query = GetUsersQuery()
            client.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                    if let result = result?.data?.users {
                        self?.users = result.map { ($0?.fragments.userData)! }
                        self?.loader.stopAnimating()
                    }
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
            self.loader.startAnimating()
            let mutation = CustomersEditMutation(_id: customerId!)


            mutation.firstName = form.rowBy(tag: "firstName")?.baseValue as? String
            mutation.lastName = form.rowBy(tag: "lastName")?.baseValue as? String
            mutation.primaryEmail = form.rowBy(tag: "primaryEmail")?.baseValue as? String
            mutation.primaryPhone = form.rowBy(tag: "primaryPhone")?.baseValue as? String
            let owner = form.rowBy(tag: "owner")?.baseValue as? UserData
            mutation.ownerId = owner?.id
            mutation.position = form.rowBy(tag: "position")?.baseValue as? String
            mutation.department = form.rowBy(tag: "department")?.baseValue as? String
            mutation.leadStatus = form.rowBy(tag: "leadStatus")?.baseValue as? String
            mutation.lifecycleState = form.rowBy(tag: "lifecycleState")?.baseValue as? String
            if (form.rowBy(tag: "hasAuthority")?.baseValue as? Bool)! {
                mutation.hasAuthority = "Yes"
            }else{
                mutation.hasAuthority = "No"
            }
            
            mutation.description = form.rowBy(tag: "description")?.baseValue as? String
            if (form.rowBy(tag: "doNotDisturb")?.baseValue as? Bool)! {
                mutation.doNotDisturb = "Yes"
            }else{
                mutation.doNotDisturb = "No"
            }
            
            mutation.links = JSON()
            var customFields = JSON()
            
            for row in form.allRows {
                if row.section?.index != 0 {
                    
                    if let textRow = row as? TextRow{
                        customFields[row.tag!] = textRow.baseValue as Any
                    }
                    
                    if let dateRow = row as? DateRow {
                        if let dateValue = dateRow.value {
                            let dateString = dateValue.mainDateString()
                            customFields[row.tag!] = dateString
                        }
                    }
                    
                    if let switchRow = row as? SwitchRow {
                        if let value = switchRow.value {
                            if value {
                                customFields[row.tag!] = "Yes"
                            }else{
                                customFields[row.tag!] = "No"
                            }
                        }
                    }
                    
                    if let multiSelectorRow = row as? MultipleSelectorRow<String> {
                        if let value = multiSelectorRow.value {
                            let arr = Array(value)
                            customFields[row.tag!] = arr
                        }
                    }
                }
            }

            mutation.customFieldsData =  customFields
            client.perform(mutation: mutation) { [weak self] result, error in
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
                  
                    self?.loader.stopAnimating()
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully")
                }
            }
        }

        func configureViews() {
            self.view.backgroundColor = .white
            self.tableView.backgroundColor = .clear
            let rightItem: UIBarButtonItem = {
                var rightImage = UIImage.erxes(with: .edit, textColor: UIColor.TEXT_COLOR)
                var saveImage = UIImage.erxes(with: .user2, textColor: UIColor.TEXT_COLOR)
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
            rightItem.tintColor = UIColor.TEXT_COLOR
            self.navigationItem.rightBarButtonItem = rightItem


            NameRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textField.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.textField.textColor = UIColor.TEXT_COLOR
            }
            TextRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textField.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.textField.textColor = UIColor.TEXT_COLOR
            }
            PhoneRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textField.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.textField.textColor = UIColor.TEXT_COLOR
            }

            EmailRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textField.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.textField.textColor = UIColor.TEXT_COLOR
            }

            DateRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR

            }

            SwitchRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.switchControl.tintColor = UIColor.TEXT_COLOR
                cell.switchControl.onTintColor = UIColor.TEXT_COLOR
            }
            IntRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            }
            ActionSheetRow<String>.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            }
            ButtonRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.tintColor = UIColor.TEXT_COLOR
                cell.accessoryView?.tintColor = UIColor.TEXT_COLOR

            }
            PushRow<CompanyDetail>.defaultCellUpdate = { cell, row in
                row.options = self.companies
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            }

            DecimalRow.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                cell.tintColor = UIColor.TEXT_COLOR
                cell.textField.font = UIFont.fontWith(type: .light, size: 14)

            }

            PushRow<UserData>.defaultCellUpdate = { cell, row in
                row.options = self.users
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                row.displayValueFor = {
                    if let t = $0 {
                        print("owner = ", t)
                        return t.details?.fullName
                    }
                    return nil
                }
            }

            PushRow<String>.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                row.displayValueFor = {
                    if let str = $0 {
                        return str
                    }
                    return nil
                }
            }

            MultipleSelectorRow<String>.defaultCellUpdate = { cell, row in
                cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                cell.textLabel?.textColor = UIColor.TEXT_COLOR
                row.displayValueFor = {
//                var values = Set<String>()
                    if let str = $0 {
                        let arr = [String](str)
                        return arr.joined(separator: ",")
                    }
                    return nil
                }
            }

//            SuggestionTableRow<CompanyDetail>.defaultCellUpdate = { cell, row in
//                row.cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
//                row.cell.textLabel?.textColor = UIColor.TEXT_COLOR
//                row.placeholder = "Type to search companies"
//                cell.textField.textColor = UIColor.TEXT_COLOR
//                cell.textField.font = UIFont.fontWith(type: .light, size: 14)
//                cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
//                cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
//                row.filterFunction = { [unowned self] text in
//                    self.companies.filter({ ($0.name?.lowercased().contains(text.lowercased()))! })
//                }
//
//            }
            self.view.addSubview(loader)

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

        convenience init(_id: String, count: Int) {
            self.init()
            self.customerId = _id
            self.messagesCount = count
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    }

    extension CompanyDetail: Equatable {
        public static func == (lhs: CompanyDetail, rhs: CompanyDetail) -> Bool {
            let isEqual = lhs.id == rhs.id
            return isEqual
        }
    }

    extension UserData: Equatable {
        public static func == (lhs: UserData, rhs: UserData) -> Bool {
            let isEqual = lhs.id == rhs.id
            return isEqual
        }
    }



    extension CompanyDetail: SuggestionValue {
        public init?(string stringValue: String) {
            return nil
        }

        // Text that is displayed as a completion suggestion.
        public var suggestionString: String {
            return names![0]!
        }
    }



