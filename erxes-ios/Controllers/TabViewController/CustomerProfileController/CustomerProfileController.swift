//
//  CustomerProfileController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 6/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo

class CustomerProfileController: UIViewController {

    var customerId:String?
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
    
    var tableView:UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.register(CustomerProfileCell.self, forCellReuseIdentifier: "CustomerProfileCell")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "AvatarCell")
        tableview.tableFooterView = UIView()
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        configureViews()
        // Do any additional setup after loading the view.
    }
    
    func configureViews(){
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
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    
    convenience init(_id:String){
        self.init()
        self.customerId = _id
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CustomerProfileController: UITableViewDelegate {
    
}

extension CustomerProfileController: UITableViewDataSource {
    
}
