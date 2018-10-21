//
//  CompanyListController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/18/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

protocol CompanyListControllerDelegate: class  {
    func didSelectCompany(company:CompanyList)
}

class CompanyListController: UIViewController {
    weak var delegate: CompanyListControllerDelegate?
    var isSearching = Bool()
    var companies = [CompanyList]() {
        didSet{
            tableView.reloadData()
        }
    }
    

    
    var companiesLimit = 20
    
    var searchField:UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 6
        field.backgroundColor = .white
        let imageView = UIImageView(image: UIImage.erxes(with: .magnifyingglass, textColor: .ERXES_COLOR))
        imageView.frame.size.width = 30
        imageView.contentMode = .scaleAspectFit
        field.leftView = imageView
        field.leftViewMode = .always
        field.placeholder = "Search"
        
        let btnCancel = UIButton(type: .custom)
        btnCancel.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        btnCancel.titleLabel?.font = UIFont.fontWith(type: .comfortaa, size: 13)
        btnCancel.setTitleColor(.ERXES_COLOR, for: .normal)
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.contentMode = UIViewContentMode.center
        btnCancel.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        field.rightView = btnCancel
        field.rightViewMode = .whileEditing
        field.font = UIFont.fontWith(type: .comfortaa, size: 15)
        field.returnKeyType = .search
        field.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: .editingChanged)
        return field
    }()
    
    @objc func cancelAction(){
        searchField.endEditing(true)
        searchField.text = ""
        isSearching = false
        self.getCompanies()
    }
    
    var searchBackGround = UIView()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 40
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Companies"
        self.view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        searchBackGround = UIView()
        searchBackGround.backgroundColor = .ERXES_COLOR
        searchBackGround.addSubview(searchField)
        searchField.delegate = self
        self.view.addSubview(searchBackGround)
        self.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        self.getCompanies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        searchBackGround.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        searchField.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(16)
            make.right.equalTo(self.view.snp.right).inset(16)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func textFieldDidChange(textfield:UITextField) {
        guard let value = searchField.text else {
            return
        }
        if searchField.text?.count == 0 {
            isSearching = false
        }else{
            self.getCompanies()
        }
        tableView.reloadData()
    }
    
    func isModal() -> Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    func getCompanies(limit: Int = 20) {
        
        let query = CompaniesQuery()
        
   
        query.searchValue = searchField.text
        query.perPage = limit
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
                if let allCompanies = result?.data?.companies {
                    self?.companies = allCompanies.map { ($0?.fragments.companyList)! }
                }
            }
        }
        
    }

}

extension CompanyListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var company:CompanyList?
 
            company = companies[indexPath.row]
    
        
        if isModal(){
            self.dismiss(animated: true) {
                self.delegate?.didSelectCompany(company: company!)
            }
        }else{
            self.delegate?.didSelectCompany(company: company!)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        if offsetY > 0 {
            let height:CGFloat = 44
            searchBackGround.frame.size.height = height + offsetY
        }
    }
}

extension CompanyListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
            return companies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        var company:CompanyList?
  
            company = companies[indexPath.row]
        
        cell.textLabel?.font = UIFont.fontWith(type: .comfortaa, size: 14)
        cell.textLabel?.text = company?.primaryName
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        self.timer.invalidate()
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        print(maximumOffset - currentOffset)
        if maximumOffset - currentOffset < 0.0 {
   
                companiesLimit = companiesLimit + 20
                self.getCompanies(limit: companiesLimit)
            
        }
    }
}

extension CompanyListController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.getCompanies()
        return true
    }
}
