//
//  TabController.swift
//  Erxes.io
//
//  Created by soyombo bat-erdene on 2/20/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit


class TabController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.barTintColor = UIColor.INBOX_BG_COLOR
        UITabBar.appearance().barTintColor = UIColor.INBOX_BG_COLOR
        // Do any additional setup after loading the view.
        setupTabs()
    }
    
    func setupTabs(){
        
//        
        let inboxVC = InboxController()
        let contactVC = ContactController()
        let settingsVC = SettingsController()
        tabBar.itemPositioning = .fill
        self.tabBar.itemSpacing = 0
        self.tabBar.itemWidth = self.view.bounds.size.width/3
        self.tabBar.barTintColor = .clear
        self.tabBar.backgroundImage = UIImage.colorForNavBar(color: UIColor.INBOX_BG_COLOR)
        UITabBar.appearance().tintColor = UIColor.ERXES_COLOR
        UITabBar.appearance().unselectedItemTintColor = UIColor.ERXES_COLOR.withAlphaComponent(0.6)
        self.tabBar.backgroundColor = UIColor.INBOX_BG_COLOR
        let imageInbox = UIImage.erxes(with: .chat, textColor: UIColor.ERXES_COLOR, size: CGSize(width: 22, height: 22))
        let imageCustomer = UIImage.erxes(with: .users, textColor: UIColor.ERXES_COLOR, size: CGSize(width: 22, height: 22))
        let imageSettings = UIImage.erxes(with: .settings, textColor: UIColor.ERXES_COLOR)
        inboxVC.tabBarItem = UITabBarItem.init(title: "INBOX", image: imageInbox, selectedImage: imageInbox)
        contactVC.tabBarItem = UITabBarItem.init(title: "CONTACTS", image: imageCustomer, selectedImage: imageCustomer)
        settingsVC.tabBarItem = UITabBarItem.init(title: "SETTINGS", image: imageSettings, selectedImage: imageSettings)
        
        self.tabBarController?.viewControllers = [inboxVC,contactVC,settingsVC]
        let nav1 = NavigationController.init(rootViewController: inboxVC)
        let nav2 = NavigationController.init(rootViewController: contactVC)
        let nav3 = NavigationController.init(rootViewController: settingsVC)

        self.viewControllers = [nav1,nav2,nav3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x:0.0, y:0.0, width:1.0, height:1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
