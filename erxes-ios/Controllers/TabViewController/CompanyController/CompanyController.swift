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
        let url = URL(string: Constants.API_ENDPOINT + "/graphql")!
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
        configureViews()
        queryCompanyDetail()
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
    
    convenience init(id:String) {
        self.init()
        self.companyId = id
    }
    
    func configureViews() {
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
//        PushRow<CompanyDetail>.defaultCellUpdate = { cell, row in
//            row.options = self.companies
//            cell.textLabel?.font = Constants.LIGHT
//            cell.textLabel?.textColor = Constants.ERXES_COLOR
//
//        }
//
//        PushRow<UserData>.defaultCellUpdate = { cell, row in
//            row.options = self.users
//            cell.textLabel?.font = Constants.LIGHT
//            cell.textLabel?.textColor = Constants.ERXES_COLOR
//            row.displayValueFor = {
//                if let t = $0 {
//                    print("owner = ", t)
//                    return t.details?.fullName
//                }
//                return nil
//            }
//        }
//
//        SuggestionTableRow<CompanyDetail>.defaultCellUpdate = { cell, row in
//            row.cell.textLabel?.font = Constants.LIGHT
//            row.cell.textLabel?.textColor = Constants.ERXES_COLOR
//            row.placeholder = "Type to search companies"
//            cell.textField.textColor = Constants.ERXES_COLOR
//            cell.textField.font = Constants.LIGHT
//            cell.detailTextLabel?.font = Constants.LIGHT
//            cell.detailTextLabel?.textColor = Constants.TEXT_COLOR
//            row.filterFunction = { [unowned self] text in
//                self.companies.filter({ ($0.name?.lowercased().contains(text.lowercased()))! })
//            }
//
//        }
        
        self.view.addSubview(loader)
    }
    
    func buildForm() {
        
        let setup:(NameCell, NameRow) -> Void = {(cell,row) in
            cell.textField.textColor = Constants.ERXES_COLOR
            cell.textField.font = Constants.LIGHT
        }
        
        form +++ Section("PROFILE")
            <<< NameRow("name") { row in
                row.title = "Name:"
                row.placeholder = "-"
                if let item = company?.name {
                    row.value = item
                }
                }
        
            <<< NameRow("email") { row in
                row.title = "email:"
                row.placeholder = "-"
                if let item = company?.email {
                    row.value = item
                }
                }
        
            <<< NameRow("size") { row in
                row.title = "size:"
                row.placeholder = "-"
                if let item = company?.size {
                    row.value = "\(item)"
                }
                }
        
        //industry
        //owner
        //parent
        
            <<< NameRow("plan") { row in
                row.title = "plan:"
                row.placeholder = "-"
                if let item = company?.plan {
                    row.value = item
                }
        }
            <<< NameRow("phone") { row in
                row.title = "phone:"
                row.placeholder = "-"
                if let item = company?.phone {
                    row.value = item
                }
        }
        
        //leadstatus
        //lifecycle state
        //business type
        //description
        //employee count
        //do not disturb radiobox
        
        +++ Section("Links")
        
            <<< NameRow("linkedin") { row in
                row.title = "linkedin:"
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

}
