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
        self.view.backgroundColor = UIColor.white
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
       
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
        self.tabBar.isTranslucent = true
        self.tabBar.clipsToBounds = true
        
        UITabBar.appearance().tintColor = UIColor.ERXES_COLOR
        
        self.tabBar.backgroundColor = UIColor.clear
        let iconSize = CGSize(width: 30, height: 30)
        
        let imageInboxSelected = UIImage.erxes(with: .speechbubble3, textColor: UIColor.ERXES_COLOR, size: CGSize(width: 36, height: 32))
        let imageCustomerSelected = UIImage.erxes(with: .users, textColor: UIColor.ERXES_COLOR, size: CGSize(width: 30, height: 27))
        let imageSettingsSelected = UIImage.erxes(with: .settings, textColor: UIColor.ERXES_COLOR, size: CGSize(width: 27, height: 27))
        
        let imageInbox = UIImage.erxes(with: .speechbubble3, textColor: UIColor.LIGHT_GRAY_COLOR, size: CGSize(width: 36, height: 32))
        let imageCustomer = UIImage.erxes(with: .users, textColor: UIColor.LIGHT_GRAY_COLOR, size: CGSize(width: 30, height: 27))
        let imageSettings = UIImage.erxes(with: .settings, textColor: UIColor.LIGHT_GRAY_COLOR, size: CGSize(width: 27, height: 27))
        
        inboxVC.tabBarItem = UITabBarItem.init(title: "", image: imageInbox, selectedImage: imageInboxSelected)
        contactVC.tabBarItem = UITabBarItem.init(title: "", image: imageCustomer, selectedImage: imageCustomerSelected)
        settingsVC.tabBarItem = UITabBarItem.init(title: "", image: imageSettings, selectedImage: imageSettingsSelected)
        
        self.tabBarController?.viewControllers = [contactVC,inboxVC,settingsVC]
        let nav1 = NavigationController.init(rootViewController: contactVC)
        let nav2 = NavigationController.init(rootViewController: inboxVC)
        let nav3 = NavigationController.init(rootViewController: settingsVC)
        
        self.viewControllers = [nav1,nav2,nav3]
        self.selectedIndex = 1
      
        
        let backGroundImage = #imageLiteral(resourceName: "tabBackGround")
        let imageView = UIImageView()
        imageView.image = backGroundImage
        imageView.contentMode = .scaleAspectFill
        let ratio = CGFloat((backGroundImage.size.width)) / CGFloat((backGroundImage.size.height))
        let imageHeight = (Constants.SCREEN_WIDTH)/ratio
        imageView.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: imageHeight)
        self.tabBar.insertSubview(imageView, at: 0)
//        self.tabBar.backgroundImage = UIImage.colorForNavBar(color: UIColor.red)
//        self.tabBar.backgroundImage = backGroundImage
        removeTabbarItemsText()
        
        for badgeView in self.tabBar.subviews[2].subviews {
            
            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(30, 30.0, 1.0)
            }
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeTabbarItemsText() {
        if let items = self.tabBar.items {
            for item in items {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 100)
                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.invalidateIntrinsicContentSize()
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
         let backGroundImage = #imageLiteral(resourceName: "tabBackGround")
        let ratio = CGFloat((backGroundImage.size.width)) / CGFloat((backGroundImage.size.height))
        let imageHeight = (Constants.SCREEN_WIDTH)/ratio
        print(imageHeight)
        tabFrame.size.height = imageHeight
        tabFrame.origin.y = Constants.SCREEN_HEIGHT-imageHeight
        if Constants.SCREEN_HEIGHT == 812 {
             tabFrame.size.height = imageHeight+20
            tabFrame.origin.y = Constants.SCREEN_HEIGHT-imageHeight-20
        }
        
        
        self.tabBar.frame = tabFrame

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
