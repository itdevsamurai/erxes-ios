//
//  EmailSignatureController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/30/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class EmailSignatureController: UIViewController {
    var brands = [BrandDetail]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var signatures = [JSON]()
    
    var picker: UIPickerView = {
        let p = UIPickerView()
//        //        p.layer.cornerRadius = 5
//        p.layer.borderColor = UIColor.init(hexString: "ab113b")!.cgColor
//        p.layer.borderWidth = 0.5
        p.showsSelectionIndicator = true
        p.backgroundColor = .white
        return p
    }()
    
    var filtered = [BrandDetail]()
    var isFiltering: Bool = false
    var selectedBrandId = String()
    var profileView: ProfileView?
    var brandField: ErxesField = {
        let field = ErxesField()
        field.titleLabel.text = "Brand"
        field.textField.placeholder = "Select brand"
//        field.textField.delegate = self
//        field.textField.addTarget(self, action: #selector(dropDownAction(textField:)), for: .editingChanged)
        return field
    }()

    var signatureView: ErxesTextView = {
        let view = ErxesTextView()
        view.titleLabel.text = "Signature"
        return view
    }()

    var saveButton: MyButton = {
        let button = MyButton()

        button.setTitle("Save", for: .normal)

        button.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)

        return button
    }()

    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
        tableview.rowHeight = 30
        tableview.tableFooterView = UIView()
        tableview.separatorColor = UIColor.clear
        tableview.backgroundColor = .white
       
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        // Do any additional setup after loading the view.
    }

    convenience init(brands: [BrandDetail]) {
        self.init()
        self.brands = brands
        self.getSignatures()
        print(self.brands)
    }



    func configureViews() {
        self.title = "Email signature"
        self.view.backgroundColor = .white
        let currentUser = ErxesUser.sharedUserInfo()
        picker.delegate = self
        picker.dataSource = self
        profileView = ProfileView(user: currentUser, style: .type2)
        self.view.addSubview(profileView!)
        self.view.addSubview(brandField)
        brandField.textField.inputView = picker
        self.view.addSubview(signatureView)
        self.view.addSubview(saveButton)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        brandField.textField.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(100)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        })

        brandField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo((profileView?.snp.bottom)!)
            make.height.equalTo(75)
        }

        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(55)
            make.right.equalTo(self.view.snp.right).inset(16)
            make.height.equalTo(0)
            make.top.equalTo(brandField.snp.bottom)
        }

        signatureView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(brandField.snp.bottom)
            make.height.equalTo(90)
        }

        saveButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(55)
            make.right.equalTo(self.view.snp.right).inset(55)
            make.height.equalTo(36)
            make.top.equalTo(signatureView.snp.bottom).offset(20)
        }

        self.view.layoutIfNeeded()
    }


    func expandTable() {
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.view.snp.left).offset(55)
                make.right.equalTo(self.view.snp.right).inset(16)
                make.bottom.equalTo(self.saveButton.snp.bottom)
                make.top.equalTo(self.brandField.snp.bottom)
            })
            self.view.layoutIfNeeded()
        })
    }

    func collapseTable() {
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.view.snp.left).offset(55)
                make.right.equalTo(self.view.snp.right).inset(16)
                make.top.equalTo(self.brandField.snp.bottom)
                make.height.equalTo(0)
            })
            self.view.layoutIfNeeded()
        })
    }

    @objc func saveAction(sender: UIButton) {
        if validate() {
            let signature = self.signatureView.textView.text
            let signatureObj = EmailSignature(brandId: self.selectedBrandId, signature: signature)
            self.insertSignature(signature: signatureObj)
        }

    }
    
    func getSignatures(){
        let query = UserEmailSignaturesQuery()
        appnet.fetch(query: query) { [weak self] result, error in
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
            
            
            if let result = result?.data?.currentUser {
                let data = result.emailSignatures
                if let array = data!["data"] as? [JSON] {
                    self?.signatures = array
                }
            }
        }
    }

    func insertSignature(signature: EmailSignature) {
        let mutation = UsersConfigEmailSignaturesMutation()
        mutation.signatures = [signature]
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {

                self?.showResult(isSuccess: false, message: error.localizedDescription, resultCompletion: nil)
                return
            }
            if let err = result?.errors {

                self?.showResult(isSuccess: false, message: err[0].localizedDescription, resultCompletion: nil)
            }
            if result?.data != nil {
                if (result?.data?.usersConfigEmailSignatures) != nil {
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully", resultCompletion: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    }


    func validate() -> Bool {
        let line1 = brandField.viewWithTag(1)
        let line2 = signatureView.viewWithTag(1)

        var results = [Bool]()
        var isValid = false


        if (brandField.textField.text?.isEmpty)! {
            line1?.backgroundColor = .red
            results.append(false)
        } else {
            line1?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }

        if (signatureView.textView.text?.isEmpty)! {
            line2?.backgroundColor = .red
            results.append(false)
        } else {
            line2?.backgroundColor = .TEXT_COLOR
            results.append(true)
        }

        if results.contains(where: { $0 == false }) {
            isValid = false
        } else {
            isValid = true
        }

        return isValid
    }
}

extension EmailSignatureController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.expandTable()
//    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        let actionSheet = uiactionsh
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        isFiltering = false
        tableView.reloadData()
        return true
    }

    @objc func dropDownAction(textField: UITextField) {
        guard let value = textField.text else {
            isFiltering = false
            tableView.reloadData()
            return
        }
        isFiltering = true
        if value.count != 0 {
            var tmp = [BrandDetail]()
            tmp = brands.filter{($0.name?.localizedCaseInsensitiveContains(value))!}
            self.filtered = tmp
            tableView.reloadData()
        } else {
            self.isFiltering = false
            tableView.reloadData()
        }
//        self.expandTable()
    }
}

extension EmailSignatureController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.brandField.textField.text = brands[indexPath.row].name
        self.brandField.textField.resignFirstResponder()
        selectedBrandId = brands[indexPath.row].id
//        self.collapseTable()
    }
}

extension EmailSignatureController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtered.count
        }
        return brands.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell
        
        if isFiltering {
           let brand = filtered[indexPath.row]
            cell?.desc.text = brand.name
        } else {
            let brand = brands[indexPath.row]
            cell?.desc.text = brand.name
        }
        
        cell?.desc.font = Font.regular(13)
        cell?.desc.textColor = UIColor(hexString: "#1f9fe2")
        
        cell?.arrow.isHidden = true
        return cell!
    }

}


extension EmailSignatureController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return brands.count
    }
    
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return cats[row]["caption"].stringValue
    //    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = Font.regular(16)
        label.textAlignment = .center
        label.textColor = .black
        label.text = brands[row].name
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let label = pickerView.view(forRow: row, forComponent: component) as? UILabel
        
        if label?.textColor == UIColor.ERXES_COLOR {
            label?.textColor = .black
        }else{
            label?.textColor = UIColor.ERXES_COLOR
        }
        brandField.textField.text = brands[row].name
        let brandId = brands[row].id
        let filtered = self.signatures.filter({$0["brandId"] as? String == brandId})
        if filtered.count != 0 {
            signatureView.textView.text = filtered[0]["signature"] as? String
        }else {
            signatureView.textView.text = ""
        }
    }
    
}
