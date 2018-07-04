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

    var customerId: String?
   
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
        didSet{
            
        }
    }
    

//    var tableView:UITableView = {
//        let tableview = UITableView()
//        tableview.backgroundColor = .clear
//        tableview.register(CustomerProfileCell.self, forCellReuseIdentifier: "CustomerProfileCell")
//        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "AvatarCell")
//        tableview.tableFooterView = UIView()
//
//        return tableview
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customer"
        self.configureViews()
        self.getCustomerData()
        // Do any additional setup after loading the view.
    }
    
    func getCustomerData(){
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
    
    func buildForm(customer:CustomerInfo){
        
        form +++ Section("PROFILE")
            <<< NameRow() { row in
                row.title = "First Name:"
                row.placeholder = "-"
                if (customer.firstName != nil)  {
                    row.value = customer.firstName
                }
                }.cellSetup({ (cell , row) in
                    cell.textField.textColor = Constants.ERXES_COLOR
                    cell.textField.font = Constants.LIGHT
                })
            <<< NameRow() { row in
                row.title = "Last Name:"
                row.placeholder = "-"
                if (customer.lastName != nil)  {
                    row.value = customer.lastName
                }
            }
            <<< EmailRow() { row in
                row.title = "Email:"
                row.placeholder = "-"
                if (customer.email != nil) {
                    row.value = customer.email
                }
            }
            <<< PhoneRow() {
                $0.title = "Phone:"
                $0.placeholder = "-"
                if (customer.phone != nil) {
                    $0.value = customer.phone
                }
            }
            <<< TextRow() {
                $0.title = "Owner:"
                $0.placeholder = "-"
                if customer.owner != nil {
                    $0.value = customer.owner?.details?.fullName
                }
            }
            <<< TextRow() {
                $0.title = "Position:"
                $0.placeholder = "-"
                if customer.position != nil {
                    $0.value = customer.position
                }
            }
            <<< TextRow() {
                $0.title = "Department:"
                $0.placeholder = "-"
                if customer.department != nil {
                    $0.value = customer.department
                }
            }
            <<< TextRow() {
                $0.title = "Lead status:"
                $0.placeholder = "-"
                if customer.leadStatus != nil {
                    $0.value = customer.leadStatus
                }
            }
            <<< TextRow() {
                $0.title = "Lifecycle State:"
                $0.placeholder = "-"
                if customer.lifecycleState != nil {
                    $0.value = customer.lifecycleState
                }
            }
            <<< SwitchRow() {
                $0.title = "Has Authority:"
                
                if customer.hasAuthority == nil {
                    $0.value = false
                }else if customer.hasAuthority == "true" {
                    $0.value = true
                }else{
                    $0.value = false
                }
                
            }
            <<< TextRow() {
                $0.title = "Description:"
                $0.placeholder = "-"
                if customer.description != nil {
                    $0.value = customer.description
                }
            }
            <<< SwitchRow() {
                $0.title = "Do not disturb:"
                if customer.doNotDisturb != nil {
                    if customer.doNotDisturb == "true"{
                        $0.value = true
                    }else{
                        $0.value = false
                    }
                }else{
                    $0.value = false
                }
            }
            +++ Section("CONVERSATION DETAILS")
            <<< TextRow() {
                $0.title = "Opened:"
                $0.placeholder = "-"
                let conversation = customer.conversations![0]
                let date = conversation?.createdAt?.dateFromUnixTime()
                $0.value = date?.stringFromDate()
            }
            <<< TextRow() {
                $0.title = "Channels:"
                $0.placeholder = "-"
                let channels = customer.integration?.channels
                if channels?.count != 0 {
                    if channels?.count == 1 {
                        $0.value = channels![0]?.name
                    }else{
                        var str = ""
                        for ch in channels! {
                            str.append((ch?.name)! + " ")
                        }
                        $0.value = str
                    }
                }
               
            }
            <<< TextRow() {
                $0.title = "Brand:"
                $0.placeholder = "-"
                if customer.integration?.brand != nil {
                    $0.value = customer.integration?.brand?.name
                }
            }
            <<< TextRow() {
                $0.title = "Integration:"
                $0.placeholder = "-"
                if customer.integration != nil {
                    $0.value = customer.integration?.kind
                }
            }
            <<< IntRow() {
                $0.title = "Conversations:"
                $0.placeholder = "-"
                if customer.conversations != nil {
                    $0.value = customer.conversations?.count
                }
            }
            +++ Section("CONTACT INFORMATION")
            <<< DateRow() {
                $0.title = "Close Date"
//                $0.value = Date(timeIntervalSinceReferenceDate: 0)
                
            }
            <<< TextRow() {
                $0.title = "Industry:"
                $0.placeholder = "-"
                if customer.companies?.count != 0 {
                    $0.value = customer.companies![0]?.industry
                }
                
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Persona:"
                $0.selectorTitle = "Select a value"
                $0.options = ["Trailblazer","Leader","Follower","Laggard","Astray"]
                $0.value = "Trailblazer"
               
            }
            +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: "COMPANIES",  { (section) in
                section.addButtonProvider = { s in
                    return ButtonRow(){ row in
                        row.title = "Add a company"
                        
                    }
                }
                section.multivaluedRowToInsertAt = { index in
                    return SuggestionTableRow<CompanyDetail>() { row in
                        
                    }
                }

            })


//            +++ Section("DEALS")
//            <<< TextRow() {
//                $0.placeholder = "-"
//            }
            +++ Section("MESSENGER USAGE")
            <<< TextRow() {
                $0.title = "Status:"
                if customer.conversations![0]?.status != nil {
                    $0.value = customer.conversations![0]?.status
                }
            }
            <<< TextRow() {
                $0.title = "Last online:"
                $0.placeholder = "-"
                if customer.conversations![0]?.updatedAt != nil {
                    $0.value = customer.conversations![0]?.updatedAt?.dateFromUnixTime().stringFromDate()
                }
            }
//            <<< TextRow() {
//                $0.title = "Session count:"
//                $0.placeholder = "-"
//            }
            +++ Section("TAGS")
            <<< TextRow() {
                if customer.getTags != nil {
                    let tags = customer.getTags
                    print(tags)
                    for tag in tags! {
                        $0.title?.append((tag?.name)! + " ")
                    }
                    
                }
        }
        self.getCompanies()
    }
    
    
    func getCompanies(){
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

    func configureViews() {
        self.view.backgroundColor = .white
        let rightItem: UIBarButtonItem = {
            var rightImage = #imageLiteral(resourceName: "ic_edit")
            rightImage = rightImage.withRenderingMode(.alwaysTemplate)
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            button.tintColor = Constants.ERXES_COLOR
//            button.addTarget(self, action: #selector(navigateProfile(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        rightItem.tintColor = Constants.ERXES_COLOR
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(loader)
 
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
        SuggestionTableRow<CompanyDetail>.defaultCellUpdate = { cell, row in
            row.cell.textLabel?.font = Constants.LIGHT
            row.cell.textLabel?.textColor = Constants.ERXES_COLOR
            row.placeholder = "Type to search companies"
            cell.textField.textColor = Constants.ERXES_COLOR
            cell.textField.font = Constants.LIGHT
            cell.detailTextLabel?.font = Constants.LIGHT
            cell.detailTextLabel?.textColor = Constants.TEXT_COLOR
            row.filterFunction = { [unowned self] text in
                self.companies.filter({($0.name?.lowercased().contains(text.lowercased()))!})
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

    convenience init(_id: String) {
        self.init()
        self.customerId = _id

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

extension CompanyDetail: SuggestionValue {
    public init?(string stringValue: String) {
        return nil
    }
    
    // Text that is displayed as a completion suggestion.
    public var suggestionString: String {
        return name!
    }
}

