//
//  ErxesUser.swift
//  erxes
//
//  Created by soyombo bat-erdene on 2/24/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ErxesUser{

    private static var info: ErxesUser?
    
    class func sharedUserInfo() -> ErxesUser
    {
        if self.info == nil
        {
            self.info = ErxesUser()
        }
        
        return self.info!
    }

    var _id:String?
    var username: String?
    var email: String?
    var role: String?
    var emailSignatures:[[String:Any]]?
    var getNotificationByEmail:Bool?
    var avatar:String?
    var fullName:String?
    var position:String?
    var twitterUsername:String?
    var token:String?
    var refreshToken:String?
    
    static let serviceName = "ErxesService"
    
    static var isSignedIn: Bool {
        if ErxesUser.storedEmail().count == 0 {
            return false
        }

        do {
            let password = try KeychainPasswordItem(service: serviceName, account: ErxesUser.storedEmail()).readPassword()
            return password.count > 0
        } catch {
            return false
        }
    }
    
    static func storedEmail() -> String {
        guard let email = UserDefaults.standard.string(forKey: "email"), email.count > 0 else {
            return ""
        }
        return email
    }
    
    static func storedPassword() -> String {
        do {
            let password = try KeychainPasswordItem(service: ErxesUser.serviceName, account: storedEmail()).readPassword()
            return password
        } catch {
            return ""
        }
    }

    class func signIn(_ email: String, password: String) throws {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.synchronize()
        try KeychainPasswordItem(service: serviceName, account: email).savePassword(password)
    }

    class func signOut() throws {
        guard let email = ErxesUser.sharedUserInfo().email else {
            return
        }
 
       try KeychainPasswordItem(service: serviceName, account: email).deleteItem()
        
      
    }
    
}
