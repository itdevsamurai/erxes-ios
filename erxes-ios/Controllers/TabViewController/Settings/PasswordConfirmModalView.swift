//
//  PasswordConfirmModalView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/2/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class PasswordConfirmModalView: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    var closeButton = UIButton()
    var saveButton = UIButton()
    var passwordField = ErxesField()
    var handler: (() -> Void)?
   
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        
        initialize()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize() {
        
        
        
        dialogView.clipsToBounds = true
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 8
        dialogView.dropShadow(color: UIColor.TEXT_COLOR, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        
        backgroundView.frame = frame
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Enter your password to Confirm"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.fontWith(type: .light, size: 15)
        titleLabel.backgroundColor = .ERXES_COLOR
        dialogView.addSubview(titleLabel)
        
        
        passwordField = ErxesField()
        passwordField.titleLabel.text = "Enter your password to Confirm".uppercased()
        
        passwordField.textField.isSecureTextEntry = true
        dialogView.addSubview(passwordField)
        
        
        saveButton = UIButton()
        saveButton.semanticContentAttribute = .forceLeftToRight
        saveButton.setImage(UIImage.erxes(with: .checked1, textColor: .white,size: CGSize(width: 14, height: 14)), for: .normal)
        saveButton.setTitle("  CONFIRM", for: .normal)
        saveButton.layer.cornerRadius = 20
        saveButton.backgroundColor = .GREEN
        saveButton.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)
        dialogView.addSubview(saveButton)
        
        closeButton = UIButton()
        closeButton.semanticContentAttribute = .forceLeftToRight
        closeButton.setImage(UIImage.erxes(with: .cancel1, textColor: .TEXT_COLOR,size: CGSize(width: 14, height: 14)), for: .normal)
        closeButton.setTitle("  CLOSE", for: .normal)
        closeButton.setTitleColor(.TEXT_COLOR, for: .normal)
        closeButton.layer.cornerRadius = 20
        closeButton.backgroundColor = .white
        closeButton.layer.borderWidth = 1.0
        closeButton.layer.borderColor = UIColor.TEXT_COLOR.cgColor
        closeButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        dialogView.addSubview(closeButton)

        
        
        
        
        
        addSubview(dialogView)
        
        dialogView.snp.makeConstraints { (make) in
            make.left.equalTo(backgroundView.snp.left).offset(20)
            make.right.equalTo(backgroundView.snp.right).inset(20)
            make.top.equalTo(backgroundView.snp.top).offset(60)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.right.equalTo(passwordField.snp.right)
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
        

    }
    
    func validate()->Bool{
        let line = passwordField.viewWithTag(1)

        if (passwordField.textField.text?.isEmpty)! {
            line?.backgroundColor = .red
            return false
           
        }else {
            line?.backgroundColor = .TEXT_COLOR
            return true
        }

    }
    
    @objc func saveAction(sender:UIButton){
        
        if validate() {
            if let handle = handler{
                handle()
            }
            dismiss(animated: true)
        }
        
    }
    
    
    @objc func closeAction(sender: UIButton) {

        dismiss(animated: true)
        
    }
    
    @objc func didTappedOnBackgroundView() {

        dismiss(animated: true)
        
    }
    
    
}
