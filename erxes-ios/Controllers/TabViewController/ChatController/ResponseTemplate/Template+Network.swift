//
//  Template+Network.swift
//  erxes-ios
//
//  Created by alternate on 11/21/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import Apollo

extension TemplateController {
    
    func fetchBrands() {
        let query = BrandsQuery()
        appnet.fetch(query: query) { result,error in
            if let list = result?.data?.brands {
                self.brands = list
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchTemplates() {
        let query = ResponseTemplatesQuery()
        appnet.fetch(query: query) { result,error in
            if let list = result?.data?.responseTemplates {
                self.templates = list
                
                if let brandId = self.brand?["_id"] as? String {
                    self.filteredTemplates = self.templates.filter { $0?.brandId ==  brandId }
                    self.tableView.reloadData()
                }
            }
        }
    }
}
