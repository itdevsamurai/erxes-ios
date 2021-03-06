//
//  ContactController.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/13/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo


class ContactController: UIViewController {

//    var linearLoader: LineProgressView = {
//       let loader = LineProgressView()
//        loader.bgColor = .clear
//        return loader
//    }()

    let arr = ["Customers", "Companies"]

    var isCustomer: Bool = true
    var customersLimit = 20
    var companiesLimit = 20
    var customers = [CustomerList]() {
        didSet {
            tableView.reloadData()
        }
    }

    var companies = [CompanyList]() {
        didSet {
            tableView.reloadData()
        }
    }


    var customerAddButton: UIButton = {
        let button = UIButton()
        let image = UIImage.erxes(with: .adduser, textColor: .white)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        return button
    }()

    var companyAddButton: UIButton = {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "ic_addCompany")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        return button
    }()



    var segmentedControl: UISegmentedControl = {
        let items = ["Customer", "Company"]
        let control = UISegmentedControl(items: items)
        control.frame = CGRect(x: 0, y: 0, width: 200, height: 23)
        control.layer.cornerRadius = 5.0
        control.tintColor = UIColor.init(hexString: "4e25a5")
        control.backgroundColor = UIColor.init(hexString: "421f8b")
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.fontWith(type: .comfortaa, size: 15)
        ]

        control.setTitleTextAttributes(attributes, for: .normal)
        control.setTitleTextAttributes(attributes, for: .selected)
        control.selectedSegmentIndex = 0


        return control
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.rowHeight = 90
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.LIGHT_GRAY_COLOR
      
        return tableView
    }()
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
                self.showActionSheet(indexPath: indexPath)
            }
        }
    }
    
    func showActionSheet(indexPath:IndexPath){
        let actionSheet = UIAlertController(title: "Connect to customer", message: "Please select connection method", preferredStyle: .actionSheet)
        if isCustomer{
            let customer = self.customers[indexPath.row]
            if !customer.primaryPhone.isNullOrEmpty{
                
                actionSheet.addAction(UIAlertAction(title: "Make a phone call", style: .default, handler: { (action) in
                    if let url = URL(string: "tel://\(customer.primaryPhone)") {
                        UIApplication.shared.openURL(url)
                    }
                }))
            }
           
            if customer.conversations?.count != 0 {
                actionSheet.addAction(UIAlertAction(title: "Go to conversation", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                    self.navigate(.chat(withId: (customer.conversations![0]?.id)!, title: "", customerId: customer.id))
                }))
            }
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
        }
        if actionSheet.actions.count > 1{
            self.present(actionSheet, animated: true)
        }
    }

    @objc func toggleSegmentedControl(sender: UISegmentedControl) {

        let leftItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            return barButtonItem
        }()

        if sender.selectedSegmentIndex == 0 {
            isCustomer = true
            customerAddButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
            leftItem.customView = customerAddButton
            if self.customers.count == 0{
                self.getCustomers()
            }
        } else {
            companyAddButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
            leftItem.customView = companyAddButton
            isCustomer = false
            if self.companies.count == 0 {
                self.getCompanies()
            }
        }
        self.navigationItem.leftBarButtonItem? = leftItem
        self.tableView.reloadData()
    }


    func configureViews() {

        let rightItem: UIBarButtonItem = {
            var rightImage = #imageLiteral(resourceName: "ic_filter")

            rightImage = rightImage.withRenderingMode(.alwaysTemplate)
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            button.tintColor = UIColor.white
            button.addTarget(self, action: #selector(changeEditMode(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        let leftItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem()
            customerAddButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
            barButtonItem.customView = self.customerAddButton
            return barButtonItem
        }()


        self.navigationItem.leftBarButtonItem = leftItem
//        self.navigationItem.rightBarButtonItem = rightItem
        segmentedControl.addTarget(self, action: #selector(toggleSegmentedControl(sender:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl

        tableView.delegate = self
        tableView.dataSource = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPress)
        self.view.addSubview(tableView)
        
    }

    func isEditing() {

    }



    @objc func changeEditMode(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tableView.isEditing = sender.isSelected
    }

    @objc func addAction(sender: UIButton) {
        print("add click")
        if isCustomer {
            navigate(.customerProfile(_id: nil))
        } else {
            navigate(.companyProfile(id: nil))
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        self.view.backgroundColor = UIColor.white
        self.configureViews()
//        self.getCustomers()
    }

    override func viewWillAppear(_ animated: Bool) {

        if isCustomer {

            getCustomers()
        } else {


            getCompanies()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()


        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(16)
            make.right.equalTo(self.view.snp.right).inset(16)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }

//        loader.snp.makeConstraints { (make) in
//            make.width.height.equalTo(50)
//            make.center.equalTo(self.view.snp.center)
//        }

    }

    func getCompanies(limit: Int = 20) {
//        self.showLoader()
        
            let query = CompaniesQuery()
            query.perPage = limit

            appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
                if let error = error {
                    print(error.localizedDescription)
                    let alert = FailureAlert(message: error.localizedDescription)
                    alert.show(animated: true)

//                self?.hideLoader()

                    return
                }

                if let err = result?.errors {
                    let alert = FailureAlert(message: err[0].localizedDescription)
                    alert.show(animated: true)
//                self?.hideLoader()

                }

                if result?.data != nil {
                    if let allCompanies = result?.data?.companies {
                        self?.companies = allCompanies.map { ($0?.fragments.companyList)! }

                    }
                }
            }
        
    }

    func getCustomers(limit: Int = 20) {

            let query = CustomersQuery()
            query.perPage = limit
            appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
                if let error = error {
                    print(error.localizedDescription)
                    let alert = FailureAlert(message: error.localizedDescription)
                    alert.show(animated: true)
//                self?.hideLoader()

                    return
                }

                if let err = result?.errors {
                    let alert = FailureAlert(message: err[0].localizedDescription)
                    alert.show(animated: true)
//                self?.hideLoader()

                }

                if result?.data != nil {
                    if let allCustomers = result?.data?.customers {
                        self?.customers = allCustomers.map { ($0!.fragments.customerList) }
                        print(self?.customers.count)


                    }
                }
            }
        
    }

    func deleteCustomer(index: Int) {
        let customer = customers[index]
        mutateDeleteCustomer(customerIds: [customer.id])
    }

    func mutateDeleteCustomer(customerIds: [String]) {
        let mutation = CustomersRemoveMutation(customerIds: customerIds)

        appnet.perform(mutation: mutation) { [weak self] result, error in
            self?.getCustomers()
        }
    }

    func deleteCompany(index: Int) {
        let company = companies[index]
        mutateDeleteCompany(companyIds: [company.id])
    }

    func mutateDeleteCompany(companyIds: [String]) {
        let mutation = CompaniesRemoveMutation(companyIds: companyIds)

        appnet.perform(mutation: mutation) { [weak self] result, error in
            self?.getCompanies()
        }
    }
}

extension ContactController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell
        if cell == nil {
            cell = ContactCell.init(style: .default, reuseIdentifier: "ContactCell")
        }
        cell?.topLabel.text = ""
        cell?.bottomLabel.text = ""
        cell?.taglistView.removeAllTags()
        if isCustomer {
            cell?.icon.image = nil
            cell?.icon.image = #imageLiteral(resourceName: "ic_avatar")
            let customer = customers[indexPath.row]
            var fullName = ""
            var contactInfo = ""
            var customerTags = [ErxesTagLabel]()
            if !customer.firstName.isNullOrEmpty && !customer.lastName.isNullOrEmpty {
                fullName = customer.firstName! + " " + customer.lastName!
            } else if customer.firstName.isNullOrEmpty && !customer.lastName.isNullOrEmpty {
                fullName = customer.lastName!
            } else if !customer.firstName.isNullOrEmpty && customer.lastName.isNullOrEmpty {
                fullName = customer.firstName!
            } else {
                fullName = "Unnamed"
            }



            if !customer.primaryEmail.isNullOrEmpty && !customer.primaryPhone.isNullOrEmpty {
                contactInfo = customer.primaryEmail!
            } else if !customer.primaryPhone.isNullOrEmpty && customer.primaryEmail.isNullOrEmpty {
                contactInfo = customer.primaryPhone!
            } else if customer.primaryPhone.isNullOrEmpty && !customer.primaryEmail.isNullOrEmpty {
                contactInfo = customer.primaryEmail!
            }
            if let tags = customer.getTags {
                for tag in tags {
                    let customerTag = ErxesTagLabel(title: (tag?.name!)!, backgroundColor: UIColor.init(hexString: (tag?.colorCode!)!)!)
                    customerTags.append(customerTag)
                }
            }


            cell?.topLabel.text = fullName
            cell?.bottomLabel.text = contactInfo
            if customerTags.count != 0 {
                cell?.taglistView.addTagViews(tagViews: customerTags)
            }
            if let twitter = customer.twitterData {
                print("twitter = ", twitter)
            }
            if let fb = customer.facebookData {
                print("fb = ", fb)
            }

            if fullName != "Unnamed" {
                cell?.icon.setImageWithString(text: fullName.uppercased(), backGroundColor: .ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
            }

            } else {
                cell?.icon.image = #imageLiteral(resourceName: "ic_company")
                let company = companies[indexPath.row]
                if company.primaryName != nil {
                    cell?.topLabel.text = company.primaryName
                }
                if company.plan != nil {
                    cell?.bottomLabel.text = company.plan
                }
                cell?.icon.setImageWithString(text: (company.primaryName?.uppercased())!, backGroundColor: .ERXES_COLOR, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontWith(type: .light, size: 14)])
            }

            return cell!
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if isCustomer {
                    deleteCustomer(index: indexPath.row)
                } else {
                    deleteCompany(index: indexPath.row)
                }
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if isCustomer {
                let customer = customers[indexPath.row]
                navigate(.customerProfile(_id: customer.id))
            } else {
                let company = companies[indexPath.row]
                navigate(.companyProfile(id: company.id))
            }

        }
    }

    extension ContactController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if isCustomer {
                return customers.count
            } else {
                return companies.count
            }
        }

        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            //        self.timer.invalidate()
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            print(maximumOffset - currentOffset)
            if maximumOffset - currentOffset < 0.0 {
                print("FETCHING")
                if isCustomer {
                    customersLimit = customersLimit + 20
                    self.getCustomers(limit: customersLimit)
                } else {
                    companiesLimit = companiesLimit + 20
                    self.getCompanies(limit: companiesLimit)
                }
            }
        }
    }



