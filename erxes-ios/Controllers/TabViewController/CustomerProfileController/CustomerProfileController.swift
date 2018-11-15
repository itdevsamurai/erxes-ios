//
//  CustomerProfileController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 6/30/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit
import Apollo
import Eureka
import ImageRow
import Alamofire
class CustomerProfileController: FormViewController {
    
    var size = 0
    var avatarUrl = String()
    var profileField = FieldGroup(id: "profile")
    var phones: [String?]?
    var emails: [String?]?
    var customerId: String?
    var messagesCount = 0
    
    var customer:CustomerInfo?{
        didSet{
            self.buildForm(customer: customer)
        }
    }
    var assignedUser: UserData? {
        didSet {
            self.form.rowBy(tag: "ownerId")?.updateCell()
        }
    }
    
    
    
    var fieldGroups = [FieldGroup]()
    
    
    
    func isEdit() -> Bool {
        return self.customerId != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.form.removeAll()
        
        self.title = "Customer"
        
        self.configureViews()
        self.getFields()
        
    }
    
    
    
    
    func getFields() {
        
        
        let query = FieldsGroupsQuery(contentType: "customer")
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataElseFetch) { [weak self] result, error in
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
                    
                    if ((self?.customerId) == nil) {
                        self?.buildForm(customer: nil)
                    } else {
                        self?.getCustomerData()
                    }
                }
            }
        }
        
    }
    
    func getCustomerData() {
        
        let query = CustomerDetailQuery(_id: self.customerId!)
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataElseFetch) { [weak self] result, error in
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
                if let result = result?.data?.customerDetail?.fragments.customerInfo {
                    self?.assignedUser = result.owner?.fragments.userData
                    self?.phones = result.phones
                    self?.emails = result.emails
                    if let avatar = result.avatar {
                        self?.avatarUrl = avatar
                    }
                    if ((self?.customer) == nil) {
                        self?.customer = result
                    }
                }
            }
        }
    }
    
    func buildForm(customer: CustomerInfo?) {
        if self.form.count != 0 {
            self.form.removeAll()
        }
        let usersController = UsersController()
        usersController.delegate = self
        
        
        
        var profile = [String: Any]()
        var customFields = [String: Any]()
        if customer != nil {
            let obj = Mirror(reflecting: customer!)
            
            
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
                var section = Section()
                section.header = HeaderFooterView(stringLiteral: group.name!)
                form +++ section
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
                                            cell.textLabel?.font = Font.light(14)
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
                                            cell.textLabel?.font = Font.light(14)
                                        }).onPresent { from, to in
                                            to.selectableRowCellUpdate = { cell, row in
                                                cell.textLabel!.font = Font.light(14)
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
                                            cell.textLabel?.font = Font.light(14)
                                        })
                            } else if field?.type == "check" {
                                form.last!
                                    <<< MultipleSelectorRow<String>(field?.id) { row in
                                        row.title = field?.text
                                        row.options = field?.options as? [String]
                                        //                                        row.value = profile[(field?.id)!] as? Set<String>
                                        }.cellSetup({ (cell, lrow) in
                                            cell.textLabel?.textColor = UIColor.TEXT_COLOR
                                            cell.textLabel?.font = Font.light(14)
                                        }).onPresent { from, to in
                                            to.selectableRowCellUpdate = { cell, row in
                                                
                                                cell.textLabel!.font = Font.light(14)
                                                cell.textLabel!.textColor = UIColor.TEXT_COLOR
                                            }
                                }
                            } else if field?.text == "Owner" {
                                
                                form.last!
                                    
                                    <<< LabelRow(field?.id) { row in
                                        row.title = field?.text
                                        row.value = self.assignedUser?.details?.fullName
                                        }.cellUpdate({ (cell, lrow) in
                                            lrow.value = self.assignedUser?.details?.fullName
                                        }).onCellSelection({ (cell, row) in
                                            self.navigationController?.pushViewController(usersController, animated: true)
                                        })
                            } else if field?.id == "primaryPhone" {
                                
                                if((customer?.phones) != nil) {
                                    if customer?.phones?.count == 0 {
                                        form.last!
                                            <<< TextRow (field?.id) { row in
                                                row.title = field?.text
                                                if let val = profile[((field?.id)!)] as? String {
                                                    row.value = val
                                                }
                                                
                                                }.cellSetup({ (cell, lrow) in
                                                    cell.textField.keyboardType = .numberPad
                                                }).onCellHighlightChanged({ (cell, trow) in
                                                    
                                                    if !trow.isHighlighted && trow.value?.count != 0 {
                                                        self.phones?.append(trow.value)
                                                    }
                                                })
                                    } else {
                                        form.last!
                                            <<< ActionSheetRow<String> (field?.id) { row in
                                                row.title = field?.text
                                                if let options = customer?.phones {
                                                    row.options = (options as! [String])
                                                }
                                                row.value = ""
                                                if let val = profile[((field?.id)!)] as? String {
                                                    row.value = val
                                                }
                                        }
                                    }
                                } else {
                                    form.last!
                                        <<< TextRow (field?.id) { row in
                                            row.title = field?.text
                                            if let val = profile[((field?.id)!)] as? String {
                                                row.value = val
                                            }
                                            }.cellSetup({ (cell, lrow) in
                                                cell.textField.keyboardType = .numberPad
                                            }).onCellHighlightChanged({ (cell, trow) in
                                                if !trow.isHighlighted && trow.value?.count != 0 {
                                                    self.phones?.append(trow.value)
                                                }
                                            })
                                }
                                
                            } else if field?.id == "primaryEmail" {
                                print(customer?.emails)
                                if((customer?.emails) != nil) {
                                    if customer?.emails?.count == 0 {
                                        form.last!
                                            <<< TextRow (field?.id) { row in
                                                row.title = field?.text
                                                if let val = profile[((field?.id)!)] as? String {
                                                    row.value = val
                                                }
                                                
                                                }.cellSetup({ (cell, lrow) in
                                                    cell.textField.keyboardType = .emailAddress
                                                }).onCellHighlightChanged({ (cell, trow) in
                                                    
                                                    if !trow.isHighlighted && trow.value?.count != 0 {
                                                        self.emails?.append(trow.value)
                                                    }
                                                })
                                    } else {
                                        form.last!
                                            <<< ActionSheetRow<String> (field?.id) { row in
                                                row.title = field?.text
                                                if let options = customer?.emails {
                                                    row.options = (options as! [String])
                                                }
                                                row.value = ""
                                                if let val = profile[((field?.id)!)] as? String {
                                                    row.value = val
                                                }
                                        }
                                    }
                                } else {
                                    form.last!
                                        <<< TextRow (field?.id) { row in
                                            row.title = field?.text
                                            if let val = profile[((field?.id)!)] as? String {
                                                row.value = val
                                            }
                                            }.cellSetup({ (cell, lrow) in
                                                cell.textField.keyboardType = .emailAddress
                                            }).onCellHighlightChanged({ (cell, trow) in
                                                print(trow.isHighlighted)
                                                if !trow.isHighlighted && trow.value?.count != 0 {
                                                    self.emails?.append(trow.value)
                                                }
                                            })
                                }
                                
                            } else if field?.id == "avatar" {
                                form.last!
                                    <<< ImageRow(field?.id) { row in
                                        row.title = field?.text
                                        if self.avatarUrl.count != 0 {
                                            let url = URL(string: self.avatarUrl)
                                            let data = try? Data(contentsOf: url!)
                                            let image = UIImage.sd_image(with: data)
                                            row.value = image
                                        }
                                        }.cellSetup({ (cell, irow) in
                                            cell.accessoryView?.layer.cornerRadius = 17
                                            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                                            cell.textLabel?.font = Font.regular(14)
                                            cell.textLabel?.textColor = .TEXT_COLOR
                                        }).onChange({ (irow) in
                                            let image = irow.value
                                            self.uploadFile(image: image!)
                                        })
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
                                            cell.textLabel?.font = Font.light(14)
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
                                            cell.textLabel?.font = Font.light(14)
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
                                            cell.textLabel?.font = Font.light(14)
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
                                            cell.textLabel?.font = Font.light(14)
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
        for row in form.allRows {
            row.baseCell.alpha = 0.7
            row.baseCell.isUserInteractionEnabled = false
            
        }
        
    }
    
    
    
    
    
    @objc func editAction(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            for row in form.allRows {
                row.baseCell.alpha = 0.7
                row.baseCell.isUserInteractionEnabled = false
                
            }
            if isEdit() {
                saveAction()
            } else {
                insertAction()
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
    
    
    func insertAction() {
        let mutation = CustomersAddMutation()
        mutation.avatar = self.avatarUrl
        mutation.firstName = form.rowBy(tag: "firstName")?.baseValue as? String
        mutation.lastName = form.rowBy(tag: "lastName")?.baseValue as? String
        mutation.primaryEmail = form.rowBy(tag: "primaryEmail")?.baseValue as? String
        mutation.primaryPhone = form.rowBy(tag: "primaryPhone")?.baseValue as? String
        mutation.ownerId = assignedUser?.id
        mutation.position = form.rowBy(tag: "position")?.baseValue as? String
        mutation.department = form.rowBy(tag: "department")?.baseValue as? String
        mutation.leadStatus = form.rowBy(tag: "leadStatus")?.baseValue as? String
        mutation.lifecycleState = form.rowBy(tag: "lifecycleState")?.baseValue as? String
        mutation.phones = self.phones
        mutation.emails = self.emails
        if (form.rowBy(tag: "hasAuthority")?.baseValue as? Bool)! {
            mutation.hasAuthority = "Yes"
        } else {
            mutation.hasAuthority = "No"
        }
        
        mutation.description = form.rowBy(tag: "description")?.baseValue as? String
        if (form.rowBy(tag: "doNotDisturb")?.baseValue as? Bool)! {
            mutation.doNotDisturb = "Yes"
        } else {
            mutation.doNotDisturb = "No"
        }
        
        mutation.links = JSON()
        
        mutation.customFieldsData = self.form.parseToServerFormat()
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                
                self?.showResult(isSuccess: false, message: error.localizedDescription, resultCompletion: nil)
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.showResult(isSuccess: false, message: err[0].localizedDescription, resultCompletion: nil)
            }
            if result?.data != nil {
                self?.showResult(isSuccess: true, message: "Success", resultCompletion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    func saveAction() {
        
        let mutation = CustomersEditMutation(_id: customerId!)
        mutation.avatar = self.avatarUrl
        mutation.firstName = form.rowBy(tag: "firstName")?.baseValue as? String
        mutation.lastName = form.rowBy(tag: "lastName")?.baseValue as? String
        mutation.primaryEmail = form.rowBy(tag: "primaryEmail")?.baseValue as? String
        mutation.primaryPhone = form.rowBy(tag: "primaryPhone")?.baseValue as? String
        mutation.ownerId = assignedUser?.id
        mutation.position = form.rowBy(tag: "position")?.baseValue as? String
        mutation.department = form.rowBy(tag: "department")?.baseValue as? String
        mutation.leadStatus = form.rowBy(tag: "leadStatus")?.baseValue as? String
        mutation.lifecycleState = form.rowBy(tag: "lifecycleState")?.baseValue as? String
        mutation.phone = self.phones
        mutation.email = self.emails
        if (form.rowBy(tag: "hasAuthority")?.baseValue as? Bool)! {
            mutation.hasAuthority = "Yes"
        } else {
            mutation.hasAuthority = "No"
        }
        
        mutation.description = form.rowBy(tag: "description")?.baseValue as? String
        if (form.rowBy(tag: "doNotDisturb")?.baseValue as? Bool)! {
            mutation.doNotDisturb = "Yes"
        } else {
            mutation.doNotDisturb = "No"
        }
        
        mutation.links = JSON()
        
        mutation.customFieldsData = self.form.parseToServerFormat()
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                
                self?.showResult(isSuccess: false, message: error.localizedDescription, resultCompletion: nil)
                return
            }
            if let err = result?.errors {
                
                self?.showResult(isSuccess: false, message: err[0].localizedDescription, resultCompletion: nil)
            }
            if result?.data != nil {
                self?.showResult(isSuccess: true, message: "Success", resultCompletion: {
                    if ((self?.parent) == nil) {
                        self?.navigationController?.popViewController(animated: true)
                    }
                    
                })
            }
        }
    }
    
    func configureViews() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
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
        
        ImageRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
        }
        
        NameRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textField.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.textField.textColor = UIColor.TEXT_COLOR
        }
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textField.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.textField.textColor = UIColor.TEXT_COLOR
        }
        
        LabelRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.detailTextLabel?.font = Font.light(14)
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            cell.accessoryType = .disclosureIndicator
        }
        
        
        DateRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.detailTextLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            
        }
        
        SwitchRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.switchControl.tintColor = UIColor.TEXT_COLOR
            cell.switchControl.onTintColor = UIColor.TEXT_COLOR
        }
        IntRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.detailTextLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
        }
        ActionSheetRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.detailTextLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
        }
        
        PushRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            row.displayValueFor = {
                if let str = $0 {
                    return str
                }
                return nil
            }
        }
        
        MultipleSelectorRow<String>.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = Font.light(14)
            cell.textLabel?.textColor = UIColor.TEXT_COLOR
            row.displayValueFor = {
                if let str = $0 {
                    let arr = [String](str)
                    return arr.joined(separator: ",")
                }
                return nil
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
    
    convenience init(_id: String?) {
        self.init()
        if let customerid = _id {
            self.customerId = customerid
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func insertAnimation(forSections sections: [Section]) -> UITableViewRowAnimation {
        return UITableViewRowAnimation.fade
    }
    
    override func insertAnimation(forRows rows: [BaseRow]) -> UITableViewRowAnimation {
        return UITableViewRowAnimation.fade
    }
    
    override func deleteAnimation(forRows rows: [BaseRow]) -> UITableViewRowAnimation {
        return UITableViewRowAnimation.none
    }
    
    override func deleteAnimation(forSections sections: [Section]) -> UITableViewRowAnimation {
        return UITableViewRowAnimation.none
    }
    
    override func reloadAnimation(oldRows: [BaseRow], newRows: [BaseRow]) -> UITableViewRowAnimation {
        return UITableViewRowAnimation.none
    }
    
    override func reloadAnimation(oldSections: [Section], newSections: [Section]) -> UITableViewRowAnimation {
        return UITableViewRowAnimation.none
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = UIColor.init(hexString: "ebebeb")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func uploadFile(image:UIImage) {
        
        let url = Constants.URL_UPLOAD
        
        if let imgData = UIImage.resize(image) as? Data{
            size = imgData.count
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useKB]
            bcf.countStyle = .file
            //            self.lblFilesize.text = bcf.string(fromByteCount: Int64(size))
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
            },
                             to:url ) {
                                (result) in
                                
                                switch result {
                                case .success(let upload, _, _):
                                    self.processUpload(upload)
                                case .failure(let encodingError):
                                    print(encodingError)
                                }
            }
        }
    }
    
    func processUpload(_ upload:UploadRequest) {
        upload.uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            //            self.progress.progress = Float(progress.fractionCompleted)
        })
        
        upload.responseString { response in
            print(response)
            if let remoteUrl = response.value{
                self.avatarUrl = remoteUrl
            }
        }
    }
    
}

extension Form {
    
    public func parseToServerFormat() -> JSON {
        var customFields = JSON()
        
        for row in self.allRows {
            if row.section?.index != 0 {
                
                if let textRow = row as? TextRow {
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
                        } else {
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
        return customFields
    }
    
}

extension CompanyList: Equatable {
    public static func == (lhs: CompanyList, rhs: CompanyList) -> Bool {
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



extension CompanyList: SuggestionValue {
    public init?(string stringValue: String) {
        return nil
    }
    
    // Text that is displayed as a completion suggestion.
    public var suggestionString: String {
        return primaryName!
    }
}

extension CustomerProfileController: UserControllerDelegate {
    func assignUser(user: UserData, conversationId: String) {
        self.assignedUser = user
    }
}


