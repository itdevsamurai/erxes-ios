//
//  PasswordSettingsController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/28/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class PasswordSettingsController: UIViewController {

    var profileView:ProfileView?
    var currentField:ErxesField = {
       let field = ErxesField()
        field.titleLabel.text = "Current password"
        field.textField.placeholder = "Current password"
        field.textField.isSecureTextEntry = true
        return field
    }()
    var newField:ErxesField = {
        let field = ErxesField()
        field.titleLabel.text = "New password"
        field.textField.placeholder = "Enter new password"
        field.textField.isSecureTextEntry = true
        return field
    }()
    var reField:ErxesField = {
        let field = ErxesField()
        field.titleLabel.text = "Re-type password to confirm"
        field.textField.placeholder = "Re-type password"
        field.textField.isSecureTextEntry = true
        return field
    }()
    
    var saveButton: MyButton = {
        let button = MyButton()
        
        button.setTitle("Save", for: .normal)
    
        button.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)
        
        return button
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        // Do any additional setup after loading the view.
    }

    func configureViews() {
        self.title = "Change Password"
        self.view.backgroundColor = .white
        let currentUser = ErxesUser.sharedUserInfo()
        profileView = ProfileView(user: currentUser,style:.type2)
        self.view.addSubview(profileView!)
        

        self.view.addSubview(currentField)
        self.view.addSubview(newField)
        self.view.addSubview(reField)
        self.view.addSubview(saveButton)
//        saveButton.backgroundColor = .green
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(100)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        })
        
        currentField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo((profileView?.snp.bottom)!)
            make.height.equalTo(75)
        }
        
        newField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(currentField.snp.bottom)
            make.height.equalTo(75)
        }
        
        reField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(newField.snp.bottom)
            make.height.equalTo(75)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(55)
            make.right.equalTo(self.view.snp.right).inset(55)
            make.height.equalTo(36)
            make.top.equalTo(reField.snp.bottom).offset(20)
        }
       
        self.view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func saveAction(sender:UIButton) {
        
        if validate() {
            let current = self.currentField.textField.text
            let new = self.newField.textField.text
            self.changePassword(new: new! , current: current!)
        }
        
    }

    func validate()->Bool {
        let line1 = currentField.viewWithTag(1)
        let line2 = newField.viewWithTag(1)
        let line3 = reField.viewWithTag(1)
        var results = [Bool]()
        var isValid = false
        if newField.textField.text != reField.textField.text || (reField.textField.text?.isEmpty)! {
            line3?.backgroundColor = .red
            results.append(false)
        } else {
            line3?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }
        
        if (currentField.textField.text?.isEmpty)! {
            line1?.backgroundColor = .red
            results.append(false)
        } else {
            line1?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }
        
        if (newField.textField.text?.isEmpty)!{
            line2?.backgroundColor = .red
            results.append(false)
        } else {
            line2?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }
        
        if results.contains(where: {$0 == false}) {
            isValid = false
        } else {
            isValid = true
        }
        
        return isValid
    }
    
    func changePassword(new:String,current:String) {
       
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

                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully", resultCompletion: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                    
                }
            }
        }
    }

}
