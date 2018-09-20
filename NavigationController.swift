//
//  NavigationController.swift
//  NMG.CRM
//
//  Created by soyombo bat-erdene on 4/6/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.fontWith(type: .comfortaa, size: 14)]
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationBar.barTintColor = .ERXES_COLOR
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
