//
//  SettingsController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
class SettingsController: UIViewController {

    var titles = ["Change Password","Email signatures","Notification settings","Sign Out"]
    var icons:[ErxesFont] = [.openlock, .email1, .switch3, .logout2]
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    var brands = [BrandDetail]()
    
    var profileView:ProfileView?
    
    
    var loader: ErxesLoader = {
        let loader = ErxesLoader()
        loader.lineWidth = 3
        return loader
    }()
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        
        tableview.rowHeight = 40
        tableview.tableFooterView = UIView()         
        return tableview
    }()
    
    func configureViews(){
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let currentUser = ErxesUser.sharedUserInfo()
        profileView = ProfileView(user: currentUser)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        profileView?.addGestureRecognizer(tap)
       
//        tableView.tableHeaderView = profileView
        self.view.addSubview(profileView!)
        self.view.addSubview(loader)
        let backGroundImage = UIImage(named: "profileBackground")
        let ratio = CGFloat((backGroundImage!.size.width)) / CGFloat((backGroundImage!.size.height))
        let imageHeight = (Constants.SCREEN_WIDTH)/ratio
        tableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer){
        let currentUser = ErxesUser.sharedUserInfo()
        self.navigate(.userProfile(id: currentUser._id!))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
         self.view.backgroundColor = UIColor.white
        
        configureViews()
        getBrands()
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentUser = ErxesUser.sharedUserInfo()
        profileView?.user = currentUser
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        })
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
 
    }
    
    func getBrands(){
        loader.startAnimating()
        let query = BrandsQuery()
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
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
                if let allBrands = result?.data?.brands {
                    self?.brands = allBrands.map { ($0?.fragments.brandDetail)! }
                    self?.loader.stopAnimating()
                    
                }
                
            }
        }
    }
    
 

    func changePassword(new:String,current:String){
        self.loader.startAnimating()
        let mutation = UsersChangePasswordMutation(currentPassword: current, newPassword: new)

        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {

                    self?.showResult(isSuccess: false, message: error.localizedDescription, resultCompletion: nil)
                return
            }
            if let err = result?.errors {
                
                self?.showResult(isSuccess: false, message: err[0].localizedDescription, resultCompletion: nil)
               
            }
            if result?.data != nil {
                if (result?.data?.usersChangePassword) != nil {
//                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully")
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully", resultCompletion:nil)
                }
                
                
            }
        }
    }
    
    func insertSignature(signature:EmailSignature){
        self.loader.startAnimating()
        let mutation = UsersConfigEmailSignaturesMutation()
        mutation.signatures = [signature]
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                
                self?.showResult(isSuccess: false, message: error.localizedDescription, resultCompletion: nil)
                return
            }
            if let err = result?.errors {
                
                self?.showResult(isSuccess: false, message: err[0].localizedDescription, resultCompletion:nil)
            }
            if result?.data != nil {
                if (result?.data?.usersConfigEmailSignatures) != nil {
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully", resultCompletion:nil)
                }
            }
        }
    }
    
    
}

extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigate(.passwordSettings())
        }else if indexPath.row == 1 {
            self.navigate(.emailSignature(brands:self.brands))
        }else if indexPath.row == 2{
            self.navigate(.notificationSettings())
        }else if indexPath.row == 3{

            self.presentAlert(title: "Sign out", msg: "Are you sure you want to sign out ?") {
                do {
                    try ErxesUser.signOut()
                    let emptyUser = ErxesUser()
                    var currentUser = ErxesUser.sharedUserInfo()
                    currentUser = emptyUser
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.synchronize()
                    self.parent?.navigationController?.popToRootViewController(animated: true)
                } catch {
                    print("sign out failure")
                }

            }
            
        }
    }
}

extension SettingsController: UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.profileView?.scrollViewDidScroll(scrollView: scrollView)

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell)!
        cell.contentView.backgroundColor = .clear
        cell.iconType = icons[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = UIImageView(image: UIImage.erxes(with: .chevron, textColor: .black, size: CGSize(width: 10, height: 10)))
        cell.desc.text = titles[indexPath.row]
       

        return cell
    }
}





