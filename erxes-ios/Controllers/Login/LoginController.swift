//
//  LoginController.swift
//  NMG.CRM
//
//  Created by soyombo bat-erdene on 4/6/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import SnapKit
import IoniconsKit
import LocalAuthentication
import Apollo
//import KCKeyboardImagePicker

class LoginController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var checkBox:UIButton =  {
        let checkButton = UIButton()

        checkButton.setImage(UIImage.erxes(with: .check, textColor: .white), for: .selected)
        checkButton.setImage(UIImage(), for: .normal)
        checkButton.alpha = 0.0
        checkButton.addTarget(self, action: #selector(onCheckBoxPress(_:)), for: .touchUpInside)
        checkButton.layer.borderColor = UIColor.white.cgColor
        checkButton.layer.borderWidth = 1.0
        return checkButton
    }()
    
    let rememberMeLabel: UILabel = {
        let rememberMe = UILabel()
        rememberMe.text = "remember me"
        rememberMe.textColor = .white
        rememberMe.font = UIFont.fontWith(type: .light, size: 12)
        rememberMe.tag = 200
        rememberMe.alpha = 0.0
        rememberMe.textAlignment = .right
        return rememberMe
    }()

    
    
    
    var loader: ErxesLoader = {
       let loader = ErxesLoader()
        loader.lineWidth = 3
        return loader
    }()
    
    var emailField: MyTextField = {
        let field = MyTextField()
        field.placeholder = "Email"
        field.attributedPlaceholder = NSAttributedString(string: "Email",
                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        field.alpha = 0.0
        field.keyboardType = .emailAddress

        return field
    }()
    
    var passwordField: MyTextField = {
        let field = MyTextField()
        field.placeholder = "Password"

        field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        field.isSecureTextEntry = true
        field.alpha = 0.0
        return field
    }()
    
    var touchIDButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ic_touchid"), for: .normal)
        button.addTarget(self, action: #selector(toggleTouchId(sender:)), for: .touchUpInside)
        button.alpha = 0.0
        return button
    }()
    
    var touchIDButtonState: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.ionicon(with: .close, textColor: .white, size: CGSize(width:16, height:16)), for: .normal)
        button.setImage(UIImage.ionicon(with: .checkmark, textColor: .white, size: CGSize(width:16, height:16)), for: .selected)
        
        if UserDefaults.standard.value(forKey: "touchEnabled") != nil {
            let isEnabled:Bool = UserDefaults.standard.bool(forKey: "touchEnabled")
            if isEnabled{
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }else{
            button.isSelected = false
        }
        button.alpha = 0.0
        button.isUserInteractionEnabled = false
        return button
    }()
    
    var signInButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = Constants.LIGHT
        button.titleLabel?.textColor = .white
        button.setTitle("SIGN IN", for: .normal)
        button.alpha = 0.0
        button.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        return button
    }()
    

    
    var logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = #imageLiteral(resourceName: "Logo")
        return logoView
    }()
    
    
    func configureViews(){
        self.view.addSubview(logoView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(touchIDButton)
        self.view.addSubview(touchIDButtonState)
        self.view.addSubview(signInButton)
        self.view.addSubview(loader)
        self.view.addSubview(rememberMeLabel)
        self.view.addSubview(checkBox)
        let rememberMe = UserDefaults.standard.bool(forKey: "rememberme")
        if rememberMe {
            emailField.text = UserDefaults.standard.string(forKey: "email")?.lowercased()
            checkBox.isSelected = true
        }
        
        
    }
    
    @objc func onCheckBoxPress(_ sender: UIButton) {
        print("click")
        if sender.isSelected{
            UserDefaults.standard.set(false, forKey: "rememberme")
            sender.isSelected = false
            print("true")
        }else{
            UserDefaults.standard.set(true, forKey: "rememberme")
            sender.isSelected = true
            print("false")
        }
//
        UserDefaults.standard.synchronize()
        
        
    }
    
    func animateViews(){

     
        UIView.animate(withDuration: 0.3, animations: {
            self.logoView.snp.remakeConstraints({ (make) in

                make.top.equalTo(self.view.snp.top).offset(Constants.SCREEN_HEIGHT/4-75/2)
            })
            self.view.layoutIfNeeded()
        }) { (completion) in
            UIView.animate(withDuration: 0.5, animations: {
                self.emailField.alpha = 1.0
                self.passwordField.alpha = 1.0
                self.touchIDButton.alpha = 1.0
                self.touchIDButtonState.alpha = 1.0
                self.signInButton.alpha = 1.0
                self.checkBox.alpha = 1.0
                self.rememberMeLabel.alpha = 1.0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoView.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(75)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(Int(Constants.SCREEN_HEIGHT/2-75/2))
            
        }
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(40)
            make.left.equalTo(self.view.snp.left).offset(30)
            make.right.equalTo(self.view.snp.right).inset(30)
            make.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailField.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(30)
            make.right.equalTo(self.view.snp.right).inset(30)
            make.height.equalTo(40)
        }
        
        rememberMeLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(passwordField.snp.right)
            make.top.equalTo(passwordField.snp.bottom).offset(20)
        })
        
        checkBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalTo(rememberMeLabel.snp.centerY)
            make.right.equalTo(rememberMeLabel.snp.left).inset(-20)
        }
        
        touchIDButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view.snp.bottom).inset(Constants.SCREEN_WIDTH/2-50)
            make.width.height.equalTo(40)
        }
        
        touchIDButtonState.snp.makeConstraints { (make) in
            make.width.height.equalTo(16)
            make.right.equalTo(touchIDButton.snp.right).offset(5)
            make.bottom.equalTo(touchIDButton.snp.bottom).offset(5)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.equalTo(self.view.snp.left).offset(30)
            make.right.equalTo(self.view.snp.right).inset(30)
            make.bottom.equalTo(self.view.snp.bottom).inset(Constants.SCREEN_HEIGHT/8-22)
        }
        loader.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view.snp.center)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.ERXES_COLOR!
        self.navigationController?.isNavigationBarHidden = true
        configureViews()
        checkAuthentication()
    }
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions
    
    func checkAuthentication() {
        if ErxesUser.isSignedIn {
            mutateLogin(email: ErxesUser.storedEmail(), password: ErxesUser.storedPassword())
        }
    }
    
    @objc func loginAction(sender:UIButton){

        
        if touchIDButtonState.isSelected{
            loader.startAnimating()
            authenticateUser()
        }else{
            if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
                let alert = FailureAlert(message: "Please fill out fields")
                alert.show(animated: true)
            }else{
                loader.startAnimating()
                mutateLogin(email: emailField.text!, password: passwordField.text!)
            }
        }
    }

    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        if UserDefaults.standard.value(forKey: "email") == nil {
                            
                            self.mutateLogin(email: self.emailField.text!, password: self.passwordField.text!)
                        }else{
                            
                            let email:String = UserDefaults.standard.value(forKey: "email") as! String
                            let password:String = UserDefaults.standard.value(forKey: "password") as! String
                          
                            self.mutateLogin(email: email, password: password)
                        }
                    } else {
                        
                        let alert = FailureAlert(message:"Authentication failed\r please try again")
                        alert.show(animated: true)
                    }
                }
            }
        } else {
            
            
            let alert = FailureAlert(message:"Your device is not configured for Touch ID.")
            alert.show(animated: true)
        }
    }
    
    func mutateLogin(email:String, password:String) {
    
        let loginMutation = LoginMutation(email:email ,password:password)
        apollo.perform(mutation: loginMutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message:error.localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message:err[0].localizedDescription)
                alert.show(animated: true)
               self?.loader.stopAnimating()
            }
            if result?.data != nil {
                
                do {
                    try ErxesUser.signIn(email, password: password)
                } catch {
                    print("Could't save user credential")
                }
                
                let currentUser = ErxesUser.sharedUserInfo()
                currentUser.token = (result?.data?.login.token)!
                currentUser.refreshToken = (result?.data?.login.refreshToken)!
                
                self?.mutateCurrrentUser()
            }

        }
    }
    
    func mutateCurrrentUser() {
        
        let client: ApolloClient = {
            let configuration = URLSessionConfiguration.default
            let currentUser = ErxesUser.sharedUserInfo()
            
            configuration.httpAdditionalHeaders = ["x-token": currentUser.token as Any,
                                                   "x-refresh-token": currentUser.refreshToken as Any]
            let url = URL(string: Constants.API_ENDPOINT)!
            
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }()
        
        let query = CurrentUserQuery()
        client.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message:error.localizedDescription)
                alert.show(animated: true)
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message:err[0].localizedDescription)
                alert.show(animated: true)
            }
            
            if result?.data != nil {
                print(result)
                let user = result?.data?.currentUser
                print("user = ", user)
                let currentUser  = ErxesUser.sharedUserInfo()
                currentUser._id = user?.id
                currentUser.username = user?.username
                currentUser.email = user?.email
                currentUser.avatar = user?.details?.avatar
                currentUser.fullName = user?.details?.fullName
                currentUser.position = user?.details?.position
                //                        currentUser.twitterUsername = user?.details?.twitterUsername
                //                        currentUser.emailSignatures = user?.emailSignatures
                currentUser.getNotificationByEmail = user?.getNotificationByEmail
                
                if (self?.touchIDButtonState.isSelected)! {
                    UserDefaults.standard.set(self?.emailField.text, forKey: "email")
                    UserDefaults.standard.set(self?.passwordField.text, forKey: "password")
                    UserDefaults.standard.synchronize()
                }
                self?.loader.stopAnimating()
                self?.navigate(.tab)
            }
        }
    }
    
    
   

    
    @objc func toggleTouchId(sender: UIButton){
        if touchIDButtonState.isSelected {
            touchIDButtonState.isSelected = false
            UserDefaults.standard.set(false, forKey: "touchEnabled")
        }else{
            touchIDButtonState.isSelected = true
            UserDefaults.standard.set(true, forKey: "touchEnabled")
        }
        UserDefaults.standard.synchronize()
    }

}


