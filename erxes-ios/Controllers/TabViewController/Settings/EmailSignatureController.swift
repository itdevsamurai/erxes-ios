//
//  EmailSignatureController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class EmailSignatureController: UIViewController {
    var brands = [BrandDetail]() {
        didSet {
            tableView.reloadData()
        }
    }
    var selectedBrandId = String()
    var profileView: ProfileView?
    var brandField: ErxesField = {
        let field = ErxesField()
        field.titleLabel.text = "Brand"
        field.textField.placeholder = "Select brand"
//        field.textField.delegate = self
        field.textField.addTarget(self, action: #selector(dropDownAction(textField:)), for: .touchDown)
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
        tableview.separatorColor = UIColor.GRAY_COLOR
        tableview.backgroundColor = .white
        tableview.layer.borderColor = UIColor.GRAY_COLOR.cgColor
        tableview.layer.borderWidth = 1.0
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
        print(self.brands)
    }



    func configureViews() {
        self.title = "Email signature"
        self.view.backgroundColor = .white
        let currentUser = ErxesUser.sharedUserInfo()
        profileView = ProfileView(user: currentUser, style: .type2)
        self.view.addSubview(profileView!)
        self.view.addSubview(brandField)

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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.expandTable()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }

    @objc func dropDownAction(textField: UITextField) {
        self.expandTable()
    }
}

extension EmailSignatureController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.brandField.textField.text = brands[indexPath.row].name
        self.brandField.textField.resignFirstResponder()
        selectedBrandId = brands[indexPath.row].id
        self.collapseTable()
    }
}

extension EmailSignatureController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell
        let brand = brands[indexPath.row]
        cell?.desc.text = brand.name
        cell?.arrow.isHidden = true
        return cell!
    }

}
