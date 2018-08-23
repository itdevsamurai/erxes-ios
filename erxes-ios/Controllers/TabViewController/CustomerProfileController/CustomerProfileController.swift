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
        let url = URL(string: Constants.API_ENDPOINT + "/graphql")!
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

        for group in fieldGroups {
            if group.isVisible! {
                form +++ Section(group.name!)
                
                let sorted = group.fields?.sorted { obj1, obj2 in
                    (obj1?.order)! < (obj2?.order)!
                }
                for field in sorted! {
                    if (field?.isVisible)! {
                        if field?.type == "firstName" || field?.type == "lastName" {
                            form.last!
                            <<< NameRow (field?.text) { row in
                                row.title = field?.text
                                row.value = customer.firstName
                            }
                        } else if field?.type == "input" && (field?.validation?.isEmpty)! {
                            form.last!
                            <<< TextRow (field?.text) { row in
                                row.title = field?.text
                            }
                        } else if field?.type == "input" && field?.validation == "number" {
                            form.last!
                            <<< IntRow (field?.text) { row in
                                row.title = field?.text
                            }
                        } else if field?.type == "input" && field?.validation == "date" {
                            form.last!
                            <<< DateRow (field?.text) { row in
                                row.title = field?.text
                            }
                        } else if field?.type == "select" {
                            form.last!
                            <<< PushRow<String> (field?.text) { row in
                                row.title = field?.text
                                row.options = field?.options as? [String]

                            }
                        } else if field?.type == "check" && field?.options == ["on", "off"] {
                            form.last!
                            <<< SwitchRow(field?.text) { row in
                                row.title = field?.text
                            }
                        } else if field?.type == "check" {
                            form.last!
                            <<< MultipleSelectorRow<String>(field?.text) { row in
                                row.title = field?.text
                                row.options = field?.options as? [String]
                            }
                        }else if field?.validation == "email" {
                            form.last!
                                <<< EmailRow(field?.id) { row in
                                    row.title = field?.text
                            }
                        }


                        for row in form.allRows {
                            row.baseCell.alpha = 0.7
                            row.baseCell.isUserInteractionEnabled = false

                        }

                    }
                }
            }
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
        let mirrored_object = Mirror(reflecting: mutation)
        for (index,attribute) in mirrored_object.children.enumerated() {
            print("index = ", index, " attribute = ", attribute)
        }
        loader.stopAnimating()
//        mutation.firstName = form.rowBy(tag: "firstName")?.baseValue as? String
//        mutation.lastName = form.rowBy(tag: "lastName")?.baseValue as? String
//        mutation.email = form.rowBy(tag: "email")?.baseValue as? String
//        mutation.phone = form.rowBy(tag: "phone")?.baseValue as? String
//        let owner = form.rowBy(tag: "owner")?.baseValue as? UserData
//        mutation.ownerId = owner?.id
//        mutation.position = form.rowBy(tag: "position")?.baseValue as? String
//        mutation.department = form.rowBy(tag: "department")?.baseValue as? String
//        mutation.leadStatus = form.rowBy(tag: "leadStatus")?.baseValue as? String
//        mutation.lifecycleState = form.rowBy(tag: "lifecycleState")?.baseValue as? String
//        mutation.hasAuthority = (form.rowBy(tag: "hasAuthority")?.baseValue as? Bool)?.description
//        mutation.description = form.rowBy(tag: "description")?.baseValue as? String
//        mutation.doNotDisturb = (form.rowBy(tag: "doNotDisturb")?.baseValue as? Bool)?.description
//        mutation.links = JSON()
//        client.perform(mutation: mutation) { [weak self] result, error in
//            if let error = error {
//                print(error.localizedDescription)
//                let alert = FailureAlert(message: error.localizedDescription)
//                alert.show(animated: true)
//                self?.loader.stopAnimating()
//                return
//            }
//            if let err = result?.errors {
//                let alert = FailureAlert(message: err[0].localizedDescription)
//                alert.show(animated: true)
//                self?.loader.stopAnimating()
//            }
//            if result?.data != nil {
//                print(result)
//                self?.loader.stopAnimating()
//
//            }
//        }
    }

    func configureViews() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .clear
        let rightItem: UIBarButtonItem = {
            var rightImage = UIImage.erxes(with: .edit, textColor: Constants.ERXES_COLOR!)
            var saveImage = UIImage.erxes(with: .user2, textColor: Constants.ERXES_COLOR!)
            rightImage = rightImage.withRenderingMode(.alwaysTemplate)
            saveImage = saveImage.withRenderingMode(.alwaysTemplate)
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            button.setBackgroundImage(saveImage, for: .selected)
//            button.tintColor = Constants.ERXES_COLOR
            button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        rightItem.tintColor = Constants.ERXES_COLOR
        self.navigationItem.rightBarButtonItem = rightItem


        NameRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textField.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.textField.textColor = Constants.TEXT_COLOR
        }
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textField.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.textField.textColor = Constants.TEXT_COLOR
        }
        PhoneRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textField.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.textField.textColor = Constants.TEXT_COLOR
        }

        EmailRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textField.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.textField.textColor = Constants.TEXT_COLOR
        }

        DateRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.detailTextLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.detailTextLabel?.textColor = Constants.ERXES_COLOR
        }

        SwitchRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.switchControl.tintColor = Constants.ERXES_COLOR
            cell.switchControl.onTintColor = Constants.ERXES_COLOR
        }
        IntRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.detailTextLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.detailTextLabel?.textColor = Constants.ERXES_COLOR
        }
        ActionSheetRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.detailTextLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.detailTextLabel?.textColor = Constants.ERXES_COLOR
        }
        ButtonRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.tintColor = Constants.ERXES_COLOR
            cell.accessoryView?.tintColor = Constants.ERXES_COLOR

        }
        PushRow<CompanyDetail>.defaultCellUpdate = { cell, row in
            row.options = self.companies
            cell.textLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR

        }

        DecimalRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            cell.tintColor = Constants.ERXES_COLOR
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)

        }

        PushRow<UserData>.defaultCellUpdate = { cell, row in
            row.options = self.users
            cell.textLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            row.displayValueFor = {
                if let t = $0 {
                    print("owner = ", t)
                    return t.details?.fullName
                }
                return nil
            }
        }

        PushRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            row.displayValueFor = {
                if let str = $0 {
                    return str
                }
                return nil
            }
        }

        MultipleSelectorRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Constants.LIGHT
            cell.textLabel?.textColor = Constants.ERXES_COLOR
            row.displayValueFor = {
//                var values = Set<String>()
                if let str = $0 {
                    let arr = [String](str)
                    return arr.joined(separator: ",")
                }
                return nil
            }
        }

        SuggestionTableRow<CompanyDetail>.defaultCellUpdate = { cell, row in
            row.cell.textLabel?.font = Constants.LIGHT
            row.cell.textLabel?.textColor = Constants.ERXES_COLOR
            row.placeholder = "Type to search companies"
            cell.textField.textColor = Constants.ERXES_COLOR
            cell.textField.font = Constants.LIGHT
            cell.detailTextLabel?.font = Constants.LIGHT
            cell.detailTextLabel?.textColor = Constants.TEXT_COLOR
            row.filterFunction = { [unowned self] text in
                self.companies.filter({ ($0.name?.lowercased().contains(text.lowercased()))! })
            }

        }
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
        return name!
    }
}



