//
//  Constants.swift
//  erxes-ios
//
//  Created by admin on 10/28/17.
//  Copyright © 2017 admin. All rights reserved.

import UIKit

class Constants: NSObject {


    static let URL_API = "https://api.crm.nmma.co/"
    static let API_ENDPOINT = URL_API + "graphql"
    static let SUBSCRITION_ENDPOINT = "wss://api.crm.nmma.co/subscriptions"
    static let URL_UPLOAD = URL_API + "upload-file"
    
    
    // MARK: List of Constants

    static let screenSize = UIScreen.main.bounds
    static let SCREEN_WIDTH = screenSize.width
    static let SCREEN_HEIGHT = screenSize.height
    

    
    // MARK: - locations
    static var LOCATIONS = [String]()
    
    static func prepare() {
        if let path = Bundle.main.path(forResource: "Locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                LOCATIONS = jsonResult as? [String] ?? []
            } catch {
                print(error)
            }
        }
    }
}
