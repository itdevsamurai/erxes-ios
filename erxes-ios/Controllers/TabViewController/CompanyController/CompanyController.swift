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
    
    var companyId:String?
    var company:CompanyDetailQuery.Data.CompanyDetail? {
        didSet {
            buildForm()
        }
    }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Company"
        loadData()
        configureViews()
        if isEdit() {
            queryCompanyDetail()
        } else {
            buildForm()
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
    
    convenience init(id:String?) {
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
            let firstRow = form.rowBy(tag: "firstName")
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
        let rightItem: UIBarButtonItem = {
            var rightImage = #imageLiteral(resourceName: "ic_edit")
            var saveImage = #imageLiteral(resourceName: "ic_saveCustomer")
            rightImage = rightImage.withRenderingMode(.alwaysTemplate)
            saveImage = saveImage.withRenderingMode(.alwaysTemplate)
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            button.setBackgroundImage(saveImage, for: .selected)
            button.tintColor = UIColor.ERXES_COLOR
            button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            if !isEdit() {
                button.isSelected = true
            }
            barButtomItem.customView = button
            return barButtomItem
        }()
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
            cell.detailTextLabel?.textColor = UIColor.ERXES_COLOR
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
        PushRow<String>.defaultCellUpdate = {cell, row in
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            cell.tintColor = UIColor.ERXES_COLOR
            cell.accessoryView?.tintColor = UIColor.ERXES_COLOR
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
        }
        
        PushRow<CompanyDetail>.defaultCellUpdate = { cell, row in
            row.options = self.companies
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR

        }

        PushRow<UserData>.defaultCellUpdate = { cell, row in
            row.options = self.users
            cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.displayValueFor = {
                if let t = $0 {
                    print("owner = ", t)
                    return t.details?.fullName
                }
                return nil
            }
        }
        
        SuggestionTableRow<UserData>.defaultCellUpdate = { cell, row in
            row.cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            row.cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.placeholder = "Type to search user"
            cell.textField.textColor = UIColor.ERXES_COLOR
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            row.filterFunction = { [unowned self] text in
                self.users.filter({ ($0.details?.fullName?.lowercased().contains(text.lowercased()))! })
            }
        }
//
        SuggestionTableRow<CompanyDetail>.defaultCellUpdate = { cell, row in
            row.cell.textLabel?.font = UIFont.fontWith(type: .light, size: 14)
            row.cell.textLabel?.textColor = UIColor.ERXES_COLOR
            row.placeholder = "Type to search companies"
            cell.textField.textColor = UIColor.ERXES_COLOR
            cell.textField.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.font = UIFont.fontWith(type: .light, size: 14)
            cell.detailTextLabel?.textColor = UIColor.TEXT_COLOR
            row.filterFunction = { [unowned self] text in
                self.companies.filter({ ($0.primaryName?.lowercased().contains(text.lowercased()))! })
            }

        }
        
        self.view.addSubview(loader)
    }
    
    func buildForm() {
        
        form +++ Section("PROFILE"){
                $0.header?.height = { 30 }
                $0.footer = HeaderFooterView(title: "")
                $0.footer?.height = { 0 }
            }
            <<< NameRow("name") { row in
                row.title = "Name:"
                row.placeholder = "-"
                if let item = company?.primaryName {
                    row.value = item
                }
            }
        
            <<< EmailRow("email") { row in
                row.title = "email:"
                row.placeholder = "-"
                if let item = company?.email {
                    row.value = item
                }
            }
        
            <<< IntRow("size") { row in
                row.title = "size:"
                row.placeholder = "-"
                if let item = company?.size {
                    row.value = item
                }
            }
        
        //industry
            <<< PushRow<String>("industry") {
                $0.title = "industry"
                $0.selectorTitle = "industry"
                $0.options = self.industries
                if let item = company?.industry {
                    $0.value = item
                }
            }
        
            <<< NameRow("plan") { row in
                row.title = "plan:"
                row.placeholder = "-"
                if let item = company?.plan {
                    row.value = item
                }
            }
            <<< PhoneRow("phone") { row in
                row.title = "phone:"
                row.placeholder = "-"
                if let item = company?.phone {
                    row.value = item
                }
            }
        
        //leadstatus
            <<< PushRow<String>("leadStatus") {
                $0.title = "leadStatus"
                $0.selectorTitle = "lead status"
                $0.options = self.leadStatus
                if let item = company?.leadStatus {
                    $0.value = item
                }
            }
            
        //lifecycle state
            <<< PushRow<String>("lifecycleState") {
                $0.title = "lifecycleState"
                $0.selectorTitle = "lifecycle state"
                $0.options = self.lifecycleStates
                if let item = company?.lifecycleState {
                    $0.value = item
                }
            }
        //business type
            <<< PushRow<String>("businessType") {
                $0.title = "businessType"
                $0.selectorTitle = "business type"
                $0.options = self.businessTypes
                if let item = company?.businessType {
                    $0.value = item
                }
            }
        //description
        //employee count
        //do not disturb radiobox
            
            <<< SwitchRow("doNotDisturb") { row in
                row.title = "Do not disturb"
                if let doNotDisturb = company?.doNotDisturb, doNotDisturb == "Yes" {
                    row.value = true
                } else {
                    row.value = false
                }
            }
            
            +++ Section("Owner"){
                $0.header?.height = { 30 }
                $0.footer = HeaderFooterView(title: "")
                $0.footer?.height = { 0 }
            }
            
            //owner
            <<< SuggestionTableRow<UserData>("owner") {
                $0.filterFunction = { [unowned self] text in
                    self.users.filter({ ($0.details?.fullName?.lowercased().contains(text.lowercased()))! })
                }
                $0.placeholder = "Search for a user"
                if let item = company?.owner {
                    let owner = UserData(id: item.id, details: UserData.Detail(fullName: item.details?.fullName, avatar: ""))
                    $0.value = owner
                }
            }
            //parent
            
            +++ Section("Parent company"){
                $0.header?.height = { 30 }
                $0.footer = HeaderFooterView(title: "")
                $0.footer?.height = { 0 }
            }
            
//            <<< SuggestionTableRow<CompanyDetail>("parentCompany") {
//                $0.filterFunction = { [unowned self] text in
//                    self.companies.filter({ ($0.name?.lowercased().contains(text.lowercased()))! })
//                }
//                $0.placeholder = "Search for a company"
//                if let item = company?.parentCompany {
//                    let parent = CompanyDetail(id: item.id, name: item.name)
//                    $0.value = parent
//                }
//            }
        
            +++ Section("Links"){
                $0.footer = HeaderFooterView(title: "")
                $0.header?.height = { 30 }
                $0.footer?.height = { 0 }
            }
        
            <<< NameRow("linkedIn") { row in
                row.title = "linkedIn:"
                row.placeholder = "-"
                if let item = company?.links?.linkedIn {
                    row.value = item
                }
        }
        
            <<< NameRow("twitter") { row in
                row.title = "twitter:"
                row.placeholder = "-"
                if let item = company?.links?.twitter {
                    row.value = item
                }
        }
        
            <<< NameRow("facebook") { row in
                row.title = "facebook:"
                row.placeholder = "-"
                if let item = company?.links?.facebook {
                    row.value = item
                }
        }
        
            <<< NameRow("github") { row in
                row.title = "github:"
                row.placeholder = "-"
                if let item = company?.links?.github {
                    row.value = item
                }
        }
        
            <<< NameRow("youtube") { row in
                row.title = "youtube:"
                row.placeholder = "-"
                if let item = company?.links?.youtube {
                    row.value = item
                }
        }
        
            <<< NameRow("website") { row in
                row.title = "website:"
                row.placeholder = "-"
                if let item = company?.links?.website {
                    row.value = item
                }
        }
        
        self.getCompanies()
        self.getUsers()
        
        if isEdit() {
            formWritable()
        }
        else {
            formReadOnly()
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
        
        client.fetch(query: query) { [weak self] result,error in
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
                self?.company = result?.data?.companyDetail
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
    
    var companies = [CompanyDetail]()
    var users = [UserData]()
    
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
    
    func mutateCompaniesAdd(){
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
        mutation.phone = form.rowBy(tag: "phone")?.baseValue as? String
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
        
        let links = ["facebook":form.rowBy(tag: "facebook")?.baseValue as? String,
                     "linkedIn":form.rowBy(tag: "linkedIn")?.baseValue as? String,
                     "github":form.rowBy(tag: "github")?.baseValue as? String,
                     "twitter":form.rowBy(tag: "twitter")?.baseValue as? String,
                     "website":form.rowBy(tag: "website")?.baseValue as? String,
                     "youtube":form.rowBy(tag: "youtube")?.baseValue as? String]
        
        mutation.links = links
        
        client.perform(mutation: mutation){ [weak self] result, error in
            if let err = error {
                print(err)
            }
            else {
                
                if let errs = result?.errors {
                    print(errs)
                }
                else {
                    print(result?.data?.companiesAdd)
                    self?.navigationController?.popViewController(animated:true)
                }
            }
        }
    }
    
    func mutateCompaiesEdit() {
        
        
        guard let comId = company?.id, comId.count > 0 else {
            return
        }
        
        let mutation = CompaniesEditMutation(_id: comId)
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
        mutation.phone = form.rowBy(tag: "phone")?.baseValue as? String
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
        
        let links = ["facebook":form.rowBy(tag: "facebook")?.baseValue as? String,
                     "linkedIn":form.rowBy(tag: "linkedIn")?.baseValue as? String,
                     "github":form.rowBy(tag: "github")?.baseValue as? String,
                     "twitter":form.rowBy(tag: "twitter")?.baseValue as? String,
                     "website":form.rowBy(tag: "website")?.baseValue as? String,
                     "youtube":form.rowBy(tag: "youtube")?.baseValue as? String]
        
        mutation.links = links
        
        client.perform(mutation: mutation){ [weak self] result, error in
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
