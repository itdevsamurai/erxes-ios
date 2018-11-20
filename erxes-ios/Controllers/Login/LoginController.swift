//
//  LoginController.swift
//  NMG.CRM
//
//  Created by soyombo bat-erdene on 4/6/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit
import SnapKit
import SpriteKit
import LocalAuthentication
import Apollo
//import KCKeyboardImagePicker

class LoginController: LoginControllerUI {

    func configureViews() {
        
    }

    @objc func onCheckBoxPress(_ sender: UIButton) {

        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        configureViews()
        self.perform(#selector(drawCircleOfDots), with: nil, afterDelay: 1)
        
        signInButton.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        checkAuthentication()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLogin = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Functions

    func checkAuthentication() {
        if ErxesUser.isSignedIn {
            isLogin = false
            mutateLogin(email: ErxesUser.storedEmail(), password: ErxesUser.storedPassword())
        }
    }

    @objc func loginAction(sender: UIButton) {

        if emailField.validate(type: .email) && passwordField.validate(type: .password) {
            isLogin = true
            self.view.endEditing(true)
//            mutateLogin(email: emailField.text!, password: passwordField.text!)

        } else if !passwordField.validate(type: .password) {
            passwordField.becomeFirstResponder()
        } else if  !emailField.validate(type: .email) {
            emailField.becomeFirstResponder()
        } else {
            emailField.becomeFirstResponder()
        }


    }

    func mutateLogin(email: String, password: String) {
        animateAlongCircle(repeatCount: Float.infinity)
        let apollo: ApolloClient = {
            let configuration = URLSessionConfiguration.default
            let url = URL(string: Constants.API_ENDPOINT)!
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }()

        let loginMutation = LoginMutation(email: email, password: password)
        apollo.perform(mutation: loginMutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                self?.stopAnimation()
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.stopAnimation()
            }
            if result?.data != nil {

                do {
                    try ErxesUser.signIn(email, password: password)
                } catch {
                    print("Could't save user credential")
                }

                let currentUser = ErxesUser.sharedUserInfo()
                currentUser.token = (result?.data?.login)!
                currentUser.refreshToken = (result?.data?.login)!

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
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                self?.stopAnimation()
                return
            }

            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.stopAnimation()
            }

            if result?.data != nil {

                let user = result?.data?.currentUser

                let currentUser = ErxesUser.sharedUserInfo()
                currentUser._id = user?.id
                currentUser.username = user?.username
                currentUser.email = user?.email
                currentUser.avatar = user?.details?.avatar
                currentUser.fullName = user?.details?.fullName
                currentUser.position = user?.details?.position
                currentUser.getNotificationByEmail = user?.getNotificationByEmail

                if (self?.checkBox.isSelected)! {
                    UserDefaults.standard.set(self?.emailField.text, forKey: "cachedEmail")
                } else {
                    UserDefaults.standard.removeObject(forKey: "cachedEmail")
                }

                self?.passwordField.text = ""
                self?.stopAnimation()
                self?.isLogin = false
                self?.navigate(.tab)
            }
        }
    }

    @objc func handleKeyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo as? Dictionary<String, Any> {
            if let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = keyboardFrameValue.cgRectValue

                UIView.animate(withDuration: 0.3, animations: {
                    self.containerView.snp.remakeConstraints { (make) in
                        make.bottom.equalTo(self.view.snp.bottom).inset(keyboardFrame.size.height)
                    }
                    self.view.layoutIfNeeded()
                })

            }
        }
    }

    @objc func handleKeyboardDidHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {return}
        UIView.animate(withDuration: duration, animations: {
            self.containerView.snp.remakeConstraints { (make) in
                make.left.equalTo(self.view.snp.left).offset(64)
                make.right.equalTo(self.view.snp.right).inset(64)
                make.height.equalTo(480)
                make.top.equalTo(self.view.snp.top).offset(98)
            }
            self.view.layoutIfNeeded()
            if self.isLogin {
                self.perform(#selector(self.signIn), with: nil, afterDelay: duration)
            }
        })
    }
    
    @objc func signIn() {
         self.mutateLogin(email: self.emailField.text!, password: self.passwordField.text!)
    }

}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField && emailField.validate(type: .email) {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField && passwordField.validate(type: .password) {
            passwordField.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        }
    
}
