//
//  UsersController.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/19/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import SDWebImage

protocol UserControllerDelegate: class  {
    func assignUser(user:UserData, conversationId:String)
}
class UsersController: UIViewController {

    
    
    var conversationId = String()
  
    weak var delegate: UserControllerDelegate?
    var isSearching = Bool()
    var users = [UserData]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var filtered = [UserData]() {
        didSet{
            tableView.reloadData()
        }
    }
    
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
        tableView.reloadData()
    }
    
    var searchBackGround = UIView()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        tableView.rowHeight = 40
        tableView.tableFooterView = UIView()
//        tableView.separatorColor = UIColor.ERXES_COLOR
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
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
        self.getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUsers(){
        
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
            filtered = users.filter{($0.details?.fullName?.localizedCaseInsensitiveContains(value))!}
            isSearching = true
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
    
}

extension UsersController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var user:UserData?
        if isSearching{
          user = filtered[indexPath.row]
        }else{
            user = users[indexPath.row]
        }
        
        if isModal(){
            self.dismiss(animated: true) {
                self.delegate?.assignUser(user: user!,conversationId: self.conversationId)
            }
        }else{
            self.delegate?.assignUser(user: user!, conversationId: "")
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

extension UsersController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filtered.count
        }else{
            return users.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
        var user:UserData?
//        let user = users[indexPath.row]
        if isSearching {
            user = filtered[indexPath.row]
        }else{
            user = users[indexPath.row]
        }
        cell?.fullName.text = ""
        cell?.avatar.image = nil
        cell?.fullName.text = user!.details?.fullName
        cell?.avatar.sd_setImage(with: URL(string: (user!.details?.avatar)!), placeholderImage: UIImage(named: "avatar.png"))
        return cell!
    }
}

extension UsersController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    

}
