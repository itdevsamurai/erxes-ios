//
//  TemplateController.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 11/21/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

protocol TempLateControllerDelegate:class {
    func templateSelected(message:String)
}

extension ChatController:TempLateControllerDelegate {
    func templateSelected(message: String) {
        manager.mutateAddMessage(msg: message, isInternal: false, mentions: [])
    }
}

class TemplateController:ViewController {
    
    weak var delegate:TempLateControllerDelegate?
    
    typealias MBrand = BrandsQuery.Data.Brand
    typealias MTemplate = ResponseTemplatesQuery.Data.ResponseTemplate
    
    var brand:EModel?
    
    var brands = [MBrand?]()
    var filteredTemplates = [MTemplate?]()
    var templates = [MTemplate?]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var section = -1
    var row = -1
    var expanded = false
    var templateIndex = -1
    let root: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    let tableView:UITableView = {
        let tv = UITableView()
        tv.register(TemplateCell.self, forCellReuseIdentifier: TemplateCell.ID)
//        tv.register(UITableViewC, forCellReuseIdentifier: TemplateCell.ID)
        return tv
    }()
    
    let templateView:UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, delay: 0.4, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor(hexString: "#000000", alpha: 0.6)
        }, completion:nil)
    }
    
    override func prepareView() {
        fetchBrands()
        fetchTemplates()
        self.view.addSubview(root)
        self.view.addSubview(templateView)
        root.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func layoutView() {
        root.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-150)
        }
        templateView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(tableView.snp.bottom)
        }
        configureHeader()
    }
    
    @objc func close(sender:UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @objc func send(sender:UIButton) {
        
        if templateIndex >= 0 {
            if let item = templates[templateIndex]?.content {
                delegate?.templateSelected(message: item)
                self.dismiss(animated: true)
            } else {
                
            }
        }
    }
    
    func configureHeader() {
        let rightButton = UIButton()
        rightButton.setTitle("Send", for: .normal)
        rightButton.titleLabel?.font = Font.bold(14)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(send(sender:)), for: .touchUpInside)
        self.root.addSubview(rightButton)
        
        let lbl = UILabel()
        lbl.text = "RESPONSE TEMPLATE"
        lbl.font = Font.bold(15)
        lbl.textAlignment = .center
        self.root.addSubview(lbl)
        
        let btnClose = UIButton()
        //        btnClose.setImage(#imageLiteral(resourceName: "ic_xMark"), for: .normal)
        btnClose.setTitle("Close", for: .normal)
        btnClose.titleLabel?.font = Font.bold(14)
        btnClose.setTitleColor(.black, for: .normal)
        btnClose.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
        root.addSubview(btnClose)
        
        lbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalTo(root.snp.centerX)
            make.height.equalTo(60)
        }
        
        rightButton.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        btnClose.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
//            make.width.height.equalTo(15)
        }
    }
}
