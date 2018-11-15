//
//  AppDelegate.swift
//  NMG.CRM
//
//  Created by soyombo bat-erdene on 4/6/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit
import Apollo

import IQKeyboardManagerSwift
import Reachability

var isOnline = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        let loginContoller = LoginController()
        let navigationController = NavigationController(rootViewController: loginContoller)
//        let backImage = UIImage.erxes(with: .leftarrow, textColor: UIColor.white)
        let backImage = UIImage(named: "ic_back")
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: Font.regular(15)
        ]
      
        UINavigationBar.appearance().titleTextAttributes = attrs
        Route.default.setupAppNavigation(appNavigation: MyAppNavigation())
        loginContoller.title = "Login"
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()
        
        //check network change
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        Constants.prepare()
        
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    @objc func reachabilityChanged(note: Notification) {

        guard let reachability = note.object as? Reachability else { return }
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            isOnline = true
        case .cellular:
            print("Reachable via Cellular")
            isOnline = true
        case .none:
            isOnline = false
            print("Network not reachable")
        }
    }
}

