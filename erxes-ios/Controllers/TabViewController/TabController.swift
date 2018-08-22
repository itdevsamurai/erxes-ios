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
        self.tabBar.barTintColor = Constants.INBOX_BG_COLOR
        UITabBar.appearance().barTintColor = Constants.INBOX_BG_COLOR
        // Do any additional setup after loading the view.
        setupTabs()
    }
    
    func setupTabs(){
        
//        
        let inboxVC = InboxController()
        let contactVC = ContactController()
        tabBar.itemPositioning = .fill
        self.tabBar.itemSpacing = 0
        self.tabBar.itemWidth = self.view.bounds.size.width/3
        self.tabBar.barTintColor = .clear
        self.tabBar.backgroundImage = UIImage.colorForNavBar(color: Constants.INBOX_BG_COLOR)
        UITabBar.appearance().tintColor = Constants.ERXES_COLOR!
        UITabBar.appearance().unselectedItemTintColor = Constants.ERXES_COLOR!.withAlphaComponent(0.6)
        self.tabBar.backgroundColor = Constants.INBOX_BG_COLOR
        let imageInbox = UIImage.erxes(with: .chat, textColor: Constants.ERXES_COLOR!, size: CGSize(width: 22, height: 22))
        let imageCustomer = UIImage.erxes(with: .users, textColor: Constants.ERXES_COLOR!, size: CGSize(width: 22, height: 22))
        inboxVC.tabBarItem = UITabBarItem.init(title: "INBOX", image: imageInbox, selectedImage: imageInbox)
        
        contactVC.tabBarItem = UITabBarItem.init(title: "CONTACTS", image: imageCustomer, selectedImage: imageCustomer)
        self.tabBarController?.viewControllers = [inboxVC,contactVC]
        let nav1 = NavigationController.init(rootViewController:inboxVC)
        let nav2 = NavigationController.init(rootViewController: contactVC)
        self.viewControllers = [nav1,nav2]
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
