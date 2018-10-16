//
//  CompanyController.swift
//  erxes-ios
//
//  Created by alternate on 8/14/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import Eureka

class CompanyController: FormViewController {
    var profileField = FieldGroup(id: "profile")
    var companyId: String?

    var companies = [CompanyList]() {
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
        self.form.removeAll()
        self.title = "Company"


        self.configureViews()
        self.getFields()
        self.getCompanies()
        self.getUsers()
        if isEdit() {
            self.queryCompanyDetail()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.form.removeAll()
        self.tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }


    }

    convenience init(id: String?) {
        self.init()
        if let id = id {
            self.companyId = id
        }
    }

    @objc func editAction(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            formReadOnly()
            saveAction()
        } else {
            sender.isSelected = true
            formWritable()
            let firstRow = form.rowBy(tag: "primaryName")
            firstRow?.baseCell.cellBecomeFirstResponder()
        }
    }

    func isEdit() -> Bool {
        return self.companyId != nil
    }

    func saveAction() {
        if isEdit() {
            mutateCompaiesEdit()
        } else {
            mutateCompaniesAdd()
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
        PushRow<CompanyList>.defaultCellUpdate = { cell, row in
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
    }

    func buildForm(company: CompanyObj?) {
        if self.form.rows.count == 0 {
            var profile = [String: Any]()
            var customFields = [String: Any]()
            if company != nil {
                let obj = Mirror(reflecting: company!)


                for case let (label?, value) in obj.children {
                    let c = value as! [String: Any]
                    profile = c

                    if let tmp = profile["customFieldsData"] as? [String: Any] {
                        customFields = tmp
                    }

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
                                        if let val = profile[((field?.id)!)] as? String {
                                            row.value = val
                                        }


                                    }
                                } else if field?.type == "input" && (field?.validation?.isEmpty)! {
                                    form.last!
                                    <<< TextRow (field?.id) { row in
                                        row.title = field?.text
                                        if let val = profile[((field?.id)!)] as? String {
                                            row.value = val
                                        }
                                    }
                                } else if field?.type == "input" && field?.validation == "number" {
                                    form.last!
                                    <<< TextRow (field?.id) { row in
                                        row.title = field?.text
                                        if let val = profile[((field?.id)!)] as? String {
                                            row.value = val
                                        }

                                    }.cellSetup({ (cell, lrow) in
                                        cell.textField.keyboardType = .numberPad
                                    })
                                } else if field?.type == "input" && field?.validation == "date" {
                                    form.last!
                                    <<< DateRow (field?.id) { row in
                                        row.title = field?.text
                                        if let val = profile[((field?.id)!)] as? Date {
                                            row.value = val
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
                                        row.value = ""
                                        if let val = profile[((field?.id)!)] as? String {
                                            row.value = val
                                        }
                                    }.cellSetup({ (cell, lrow) in
                                        cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                        cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                    }).onPresent { from, to in
                                        to.selectableRowCellUpdate = { cell, row in
                                            cell.textLabel!.font = UIFont.fontWith(type: .light, size: 14)
                                            cell.textLabel!.textColor = UIColor.TEXT_COLOR
                                        }
                                    }
                                } else if field?.type == "check" && field?.options == ["on", "off"] {
                                    form.last!
                                    <<< SwitchRow(field?.id) { row in
                                        row.title = field?.text
                                        row.value = false
                                        if let state = profile[((field?.id)!)] as? String {
                                            if state == "Yes" {
                                                row.value = true
                                            } else {
                                                row.value = false
                                            }
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

                                            cell.textLabel!.font = UIFont.fontWith(type: .light, size: 14)
                                            cell.textLabel!.textColor = UIColor.TEXT_COLOR
                                        }
                                    }
                                } else if field?.validation == "email" {
                                    form.last!
                                    <<< EmailRow(field?.id) { row in
                                        row.title = field?.text
                                        if let val = profile[((field?.id)!)] as? String {
                                            row.value = val
                                        }
                                    }
                                } else if field?.text == "Owner" {

                                    form.last!
                                    <<< PushRow<UserData>(field?.id) { row in
                                        row.title = field?.text
                                        row.options = self.users
                                        row.value = company?.owner?.fragments.userData
                                    }.cellSetup({ (cell, lrow) in
                                        cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                        cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                        lrow.displayValueFor = {
                                            if let t = $0 {
                                                print("owner = ", t)
                                                return t.details?.fullName
                                            }
                                            return nil
                                        }
                                    }).onPresent { from, to in
                                        to.selectableRowCellUpdate = { cell, row in
                                            cell.textLabel!.font = UIFont.fontWith(type: .light, size: 14)
                                            cell.textLabel!.textColor = UIColor.TEXT_COLOR
                                        }
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

                                        if let val = customFields[((field?.id)!)] as? String {
                                            row.value = val
                                        }

                                    }
                                } else if field?.type == "input" && (field?.validation?.isEmpty)! {
                                    form.last!
                                    <<< TextRow (field?.id) { row in
                                        row.title = field?.text
                                        if let val = customFields[((field?.id)!)] as? String {
                                            row.value = val
                                        }
                                    }
                                } else if field?.type == "input" && field?.validation == "number" {
                                    form.last!
                                    <<< TextRow (field?.id) { row in

                                        row.title = field?.text
                                        if let val = customFields[((field?.id)!)] as? String {
                                            row.value = val
                                        }
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
                                        row.value = ""
                                        if let val = customFields[((field?.id)!)] as? String {
                                            row.value = val
                                        }
                                    }.cellSetup({ (cell, lrow) in
                                        cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                        cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
                                    })
                                } else if field?.type == "check" && field?.options == ["on", "off"] {
                                    form.last!
                                    <<< SwitchRow(field?.id) { row in
                                        row.title = field?.text
                                        row.value = false
                                        if let state = customFields[((field?.id)!)] as? String {
                                            if state == "Yes" {
                                                row.value = true
                                            } else {
                                                row.value = false
                                            }
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
                                        if let val = customFields[((field?.id)!)] as? String {
                                            row.value = val
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }


            if isEdit() {
                formWritable()
            }
            else {
                formReadOnly()
            }
        }
    }

    func formWritable() {
        for row in form.allRows {
            row.baseCell.alpha = 0.7
            row.baseCell.isUserInteractionEnabled = false
        }
    }

    func formReadOnly() {
        for row in form.allRows {
            row.baseCell.alpha = 1.0
            row.baseCell.isUserInteractionEnabled = true
        }
    }

    func queryCompanyDetail() {
        guard let comId = self.companyId else {
            return
        }

        let query = CompanyDetailQuery(id: comId)

        appnet.fetch(query: query) { [weak self] result, error in
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


            if let result = result?.data?.companyDetail?.fragments.companyObj {
                self?.buildForm(company: result)
            }
        }
    }

    func getFields() {


        let query = FieldsGroupsQuery(contentType: "company")
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                if let resultData = result?.data?.fieldsGroups {

                    self?.fieldGroups = resultData.map { ($0?.fragments.fieldGroup)! }

                    self?.profileField.isVisible = true
                    self?.profileField.name = "PROFILE"
                    self?.profileField.order = -1
                    //                    self?.profileField.fields = [field]
                    var fieldsArray = [FieldGroup.Field]()

                    if let path = Bundle.main.path(forResource: "Company", ofType: "json") {
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
                    if !(self?.isEdit())! {
                        self?.buildForm(company: nil)
                    }
                }
            }
        }

    }

    var industries = [String]()
    var leadStatus = [String]()
    var lifecycleStates = [String]()
    var businessTypes = [String]()

    func loadData() {
        if let path = Bundle.main.path(forResource: "Industry", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String] {
                    industries = jsonResult
                }
            } catch {
                // handle error
                print(error)
            }
        }

        if let path = Bundle.main.path(forResource: "LeadStatus", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String] {
                    leadStatus = jsonResult
                }
            } catch {
                // handle error
                print(error)
            }
        }

        if let path = Bundle.main.path(forResource: "LifecycleState", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String] {
                    lifecycleStates = jsonResult
                }
            } catch {
                // handle error
                print(error)
            }
        }

        if let path = Bundle.main.path(forResource: "BusinessType", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String] {
                    businessTypes = jsonResult
                }
            } catch {
                // handle error
                print(error)
            }
        }
    }



    func getCompanies() {


        let query = CompaniesQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                if let allCompanies = result?.data?.companies {

                    self?.companies = allCompanies.map { ($0?.fragments.companyList)! }




                }
            }
        }

    }

    func getUsers() {

        let query = GetUsersQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
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
                if let result = result?.data?.users {
                    self?.users = result.map { ($0?.fragments.userData)! }

                }
            }
        }

    }

    func mutateCompaniesAdd() {
        if self.companyId != nil {
            return
        }

        let mutation = CompaniesAddMutation()
        //        mutation.name = form.rowBy(tag: "name")?.baseValue as? String
        mutation.email = form.rowBy(tag: "email")?.baseValue as? String
        mutation.size = form.rowBy(tag: "size")?.baseValue as? Int
        //        mutation.website = form.rowBy(tag: "website")?.baseValue as? String
        mutation.industry = form.rowBy(tag: "industry")?.baseValue as? String ?? ""
        //        mutation.plan = form.rowBy(tag: "plan")?.baseValue as? String
        let parent = form.rowBy(tag: "parentCompany")?.baseValue as? CompanyDetail
        mutation.parentCompanyId = parent?.id
        let owner = form.rowBy(tag: "owner")?.baseValue as? UserData
        mutation.ownerId = owner?.id
        mutation.phones = [form.rowBy(tag: "phones")?.baseValue as? String]
        mutation.leadStatus = form.rowBy(tag: "leadStatus")?.baseValue as? String ?? ""
        mutation.lifecycleState = form.rowBy(tag: "lifecycleState")?.baseValue as? String ?? ""
        mutation.businessType = form.rowBy(tag: "businessType")?.baseValue as? String ?? ""
        mutation.description = form.rowBy(tag: "description")?.baseValue as? String
        //        mutation.employees = form.rowBy(tag: "employees")?.baseValue as? Int
        mutation.doNotDisturb = form.rowBy(tag: "doNotDisturb")?.baseValue as? String

        //        mutation.tagIds = form.rowBy(tag: "name")?.baseValue as? String
        //        mutation.customFieldsData = form.rowBy(tag: "name")?.baseValue as? String

        if let item = form.rowBy(tag: "doNotDisturb")?.baseValue as? Bool, item {
            mutation.doNotDisturb = "Yes"
        } else {
            mutation.doNotDisturb = "No"
        }

        let links = ["facebook": form.rowBy(tag: "facebook")?.baseValue as? String,
            "linkedIn": form.rowBy(tag: "linkedIn")?.baseValue as? String,
            "github": form.rowBy(tag: "github")?.baseValue as? String,
            "twitter": form.rowBy(tag: "twitter")?.baseValue as? String,
            "website": form.rowBy(tag: "website")?.baseValue as? String,
            "youtube": form.rowBy(tag: "youtube")?.baseValue as? String]

        mutation.links = links

        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let err = error {
                print(err)
            }
            else {

                if let errs = result?.errors {
                    print(errs)
                }
                else {
                    if ((self?.parent) == nil) {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }

    func mutateCompaiesEdit() {


        //        guard let comId = company?.id, comId.count > 0 else {
        //            return
        //        }

        let mutation = CompaniesEditMutation(_id: self.companyId!)
        mutation.primaryName = form.rowBy(tag: "name")?.baseValue as? String
        mutation.email = form.rowBy(tag: "email")?.baseValue as? String
        mutation.size = form.rowBy(tag: "size")?.baseValue as? Int
        //        mutation.website = form.rowBy(tag: "website")?.baseValue as? String
        mutation.industry = form.rowBy(tag: "industry")?.baseValue as? String
        //        mutation.plan = form.rowBy(tag: "plan")?.baseValue as? String
        let parent = form.rowBy(tag: "parentCompany")?.baseValue as? CompanyDetail
        mutation.parentCompanyId = parent?.id
        let owner = form.rowBy(tag: "owner")?.baseValue as? UserData
        mutation.ownerId = owner?.id
        mutation.phones = [form.rowBy(tag: "phones")?.baseValue as? String]
        mutation.leadStatus = form.rowBy(tag: "leadStatus")?.baseValue as? String
        mutation.lifecycleState = form.rowBy(tag: "lifecycleState")?.baseValue as? String
        mutation.businessType = form.rowBy(tag: "businessType")?.baseValue as? String
        mutation.description = form.rowBy(tag: "description")?.baseValue as? String
        //        mutation.employees = form.rowBy(tag: "employees")?.baseValue as? Int
        mutation.doNotDisturb = form.rowBy(tag: "doNotDisturb")?.baseValue as? String

        //        mutation.tagIds = form.rowBy(tag: "name")?.baseValue as? String
        //        mutation.customFieldsData = form.rowBy(tag: "name")?.baseValue as? String

        if let item = form.rowBy(tag: "doNotDisturb")?.baseValue as? Bool, item {
            mutation.doNotDisturb = "Yes"
        } else {
            mutation.doNotDisturb = "No"
        }

        let links = ["facebook": form.rowBy(tag: "facebook")?.baseValue as? String,
            "linkedIn": form.rowBy(tag: "linkedIn")?.baseValue as? String,
            "github": form.rowBy(tag: "github")?.baseValue as? String,
            "twitter": form.rowBy(tag: "twitter")?.baseValue as? String,
            "website": form.rowBy(tag: "website")?.baseValue as? String,
            "youtube": form.rowBy(tag: "youtube")?.baseValue as? String]

        mutation.links = links

        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let err = error {
                print(err)
            }
            else {
                print(result?.data?.companiesEdit)
            }
        }
    }

}

extension UserData: SuggestionValue {
    public init?(string stringValue: String) {
        return nil
    }

    // Text that is displayed as a completion suggestion.
    public var suggestionString: String {
        return (details?.fullName)!
    }
}
