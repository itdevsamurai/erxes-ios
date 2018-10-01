//
//  MyAppNavigation.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/7/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

class MyAppNavigation: RuntimeInjectable, AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? MyNavigation {
            switch navigation {
            case .tab:
                return TabController()
            case .chat(let chatId, let title, let customerId):
                return ColChatController(chatId: chatId,title:title,customerId:customerId)
            case .customerProfile(let id):
                return CustomerProfileController(_id: id)
            case .companyProfile(let id):
                return CompanyController(id: id)
            case .userProfile(let id):
                return UserProfileController(_id: id)
            case .passwordSettings():
                return PasswordSettingsController()
            case .emailSignature(let brands):
                return EmailSignatureController(brands: brands)
            case .notificationSettings():
                return NotificationSettingsController()
            }
        }
        return UIViewController()
    }
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        to.hidesBottomBarWhenPushed = true
        from.navigationController?.pushViewController(to, animated: true)
    }
        
    

}

enum MyNavigation: Navigation {
    case tab
    case chat(withId:String,title:String,customerId:String)
    case customerProfile(_id:String?)
    case companyProfile(id:String?)
    case userProfile(id:String)
    case passwordSettings()
    case emailSignature(brands:[BrandDetail])
    case notificationSettings()
}
