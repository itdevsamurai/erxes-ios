//
//  EmailSignaturesModalView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/31/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class EmailSignaturesModalView: UIView ,Modal{

    var backgroundView = UIView()
    var dialogView = UIView()
    var closeButton = UIButton()
    var saveButton = UIButton()
    var brandField = ErxesField()
    var signatureView = ErxesTextView()
 
    
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
        dialogView.dropShadow(color: Constants.ERXES_COLOR!, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        
        backgroundView.frame = frame
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Email signatures"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.fontWith(type: .light, size: 15)
        titleLabel.backgroundColor = .ERXES_COLOR
        dialogView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .TEXT_COLOR
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.fontWith(type: .light, size: 14)
        descriptionLabel.text = "  Signatures are only included in response emails.\r  You can use Markdown to format your signature."
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.backgroundColor = UIColor.init(hexString: "eeeeee")
        dialogView.addSubview(descriptionLabel)
        let line = UIView()
        line.backgroundColor = .ERXES_COLOR
        descriptionLabel.addSubview(line)
        
        
        brandField = ErxesField()
        brandField.titleLabel.text = "Brand".uppercased()
        brandField.textField.placeholder = "Brand"
        dialogView.addSubview(brandField)
        
        signatureView = ErxesTextView()
        signatureView.titleLabel.text  = "signature".uppercased()
        dialogView.addSubview(signatureView)
        
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
        
        descriptionLabel.snp.makeConstraints { (make ) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }
        
        brandField.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
        }
        
        signatureView.snp.makeConstraints { (make) in
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.right.equalTo(dialogView.snp.right).inset(20)
            make.height.equalTo(70)
            make.top.equalTo(brandField.snp.bottom).offset(20)
        }
        
    
        
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.right.equalTo(brandField.snp.right)
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.left.equalTo(dialogView.snp.left).offset(20)
            make.bottom.equalTo(dialogView.snp.bottom).inset(20)
        }
    }
    

    
  
    
    @objc func closeAction(sender: UIButton) {
        dismiss(animated: true)
        closeButton.isHidden = true
        if let handle = handler {
            handle()
        }
    }
    
    @objc func didTappedOnBackgroundView() {
        closeButton.isHidden = true
        dismiss(animated: true)
        if let handle = handler {
            handle()
        }
    }
    
    @objc func saveAction(sender:UIButton){
        
            if let handle = handler{
                handle()
            }
            dismiss(animated: true)
        
        
    }

}
