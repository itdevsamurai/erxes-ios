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
    let signatureView = EmailSignaturesModalView()
    let notificationView = NotificationSettingsModalView()
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
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return self.profileView
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
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


extension SettingsController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var subString = (textField.text!.capitalized as NSString).replacingCharacters(in: range, with: string) // 2
        subString = formatSubstring(subString: subString)
        print(subString)
        if subString.count == 0 {
            resetValues()
        } else {
            searchAutocompleteEntriesWIthSubstring(substring: subString)
        }
        return true
    }
    
    func formatSubstring(subString: String) -> String {
        let formatted = String(subString.dropLast(autoCompleteCharacterCount)).lowercased().capitalized //5
        return formatted
    }
    
    func resetValues() {
        autoCompleteCharacterCount = 0
        signatureView.brandField.textField.text = ""
    }
    
    func searchAutocompleteEntriesWIthSubstring(substring: String) {
        let userQuery = substring
        let suggestions = getAutocompleteSuggestions(userText: substring) //1
    
        if suggestions.count > 0 {
            timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { (timer) in //2
                let autocompleteResult = self.formatAutocompleteResult(substring: substring, possibleMatches: suggestions ) // 3
                self.putColourFormattedTextInTextField(autocompleteResult: autocompleteResult, userQuery : userQuery) //4
                self.moveCaretToEndOfUserQueryPosition(userQuery: userQuery) //5
            })
        } else {
            timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { (timer) in //7
                self.signatureView.brandField.textField.text = substring
            })
            autoCompleteCharacterCount = 0
        }
    }
    
    func getAutocompleteSuggestions(userText: String) -> [BrandDetail]{
        var possibleMatches: [BrandDetail] = []
        for item in brands {
         
            let myString:NSString! = item.name! as NSString
            let substringRange :NSRange! = myString.range(of: userText.lowercased())
            print(myString)
            print(substringRange)
            if (substringRange.location == 0)
            {
                possibleMatches.append(item)
            }
        }
        
        return possibleMatches
    }
    
    func putColourFormattedTextInTextField(autocompleteResult: String, userQuery : String) {
        let colouredString: NSMutableAttributedString = NSMutableAttributedString(string: userQuery + autocompleteResult)
        colouredString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.ERXES_COLOR, range: NSRange(location: userQuery.count,length:autocompleteResult.count))
        self.signatureView.brandField.textField.attributedText = colouredString
    }
    func moveCaretToEndOfUserQueryPosition(userQuery : String) {
        if let newPosition = self.signatureView.brandField.textField.position(from: self.signatureView.brandField.textField.beginningOfDocument, offset: userQuery.count) {
            self.signatureView.brandField.textField.selectedTextRange = self.signatureView.brandField.textField.textRange(from: newPosition, to: newPosition)
        }
        let selectedRange: UITextRange? = signatureView.brandField.textField.selectedTextRange
        signatureView.brandField.textField.offset(from: signatureView.brandField.textField.beginningOfDocument, to: (selectedRange?.start)!)
    }
    func formatAutocompleteResult(substring: String, possibleMatches: [BrandDetail]) -> String {
        var autoCompleteResult = possibleMatches[0].name as! String
        autoCompleteResult.removeSubrange(autoCompleteResult.startIndex..<autoCompleteResult.index(autoCompleteResult.startIndex, offsetBy: substring.count))
        autoCompleteCharacterCount = autoCompleteResult.count
        return autoCompleteResult
    }
}


