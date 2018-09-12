//
//  PasswordModalView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/31/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

class PasswordModalView: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    var closeButton = UIButton()
    var saveButton = UIButton()
    var currentField = ErxesField()
    var newField = ErxesField()
    var reField = ErxesField()
    
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
        dialogView.dropShadow(color: UIColor.ERXES_COLOR, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        
        backgroundView.frame = frame
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)

        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Change Password"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.fontWith(type: .light, size: 15)
        titleLabel.backgroundColor = .ERXES_COLOR
        dialogView.addSubview(titleLabel)
  
        currentField = ErxesField()
        currentField.titleLabel.text = "current password".uppercased()
        currentField.textField.placeholder = "Current password"
        currentField.textField.isSecureTextEntry = true
        dialogView.addSubview(currentField)
        
        newField = ErxesField()
        newField.titleLabel.text = "New password".uppercased()
        newField.textField.placeholder = "Enter new password"
        newField.textField.isSecureTextEntry = true
        dialogView.addSubview(newField)
        
        reField = ErxesField()
        reField.titleLabel.text = "re-type password to confirm".uppercased()
        reField.textField.placeholder = "Re-type password"
        reField.textField.isSecureTextEntry = true
        dialogView.addSubview(reField)
        
        saveButton = UIButton()
        saveButton.semanticContentAttribute = .forceLeftToRight
        saveButton.setImage(UIImage.erxes(with: .checked1, textColor: .white,size: CGSize(width: 14, height: 14)), for: .normal)
        saveButton.setTitle("  SAVE", for: .normal)
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
        
        currentField.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        newField.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        reField.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        addSubview(dialogView)
        
        dialogView.snp.makeConstraints { (make) in
            make.left.equalTo(backgroundView.snp.left).offset(20)
            make.right.equalTo(backgroundView.snp.right).inset(20)
            make.top.equalTo(backgroundView.snp.top).offset(60)
            make.height.equalTo(330)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        currentField.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        newField.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(currentField.snp.bottom).offset(20)
        }
        
        reField.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(newField.snp.bottom).offset(20)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.right.equalTo(reField.snp.right)
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
     
    }
    
    func validate()->Bool{
        let line1 = currentField.viewWithTag(1)
        let line2 = newField.viewWithTag(1)
        let line3 = reField.viewWithTag(1)
        var results = [Bool]()
        var isValid = false
        if newField.textField.text != reField.textField.text || (reField.textField.text?.isEmpty)! {
            line3?.backgroundColor = .red
            results.append(false)
        }else {
            line3?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }
        
        if (currentField.textField.text?.isEmpty)! {
            line1?.backgroundColor = .red
            results.append(false)
        }else {
            line1?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }
        
        if (newField.textField.text?.isEmpty)!{
            line2?.backgroundColor = .red
            results.append(false)
        }else{
            line2?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }
        
        if results.contains(where: {$0 == false}) {
            isValid = false
        }else{
            isValid = true
        }

        return isValid
    }
    
    @objc func closeAction(sender: UIButton) {
        dismiss(animated: true)
        
      
    }
    
    @objc func didTappedOnBackgroundView() {
        
        dismiss(animated: true)
 
    }
    
    @objc func saveAction(sender:UIButton){
        
        if validate() {
            if let handle = handler{
                handle()
            }
            dismiss(animated: true)
        }
        
    }
}
