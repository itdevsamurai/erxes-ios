//
//  Template+TableView.swift
//  erxes-ios
//
//  Created by alternate on 11/21/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit

extension TemplateController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if expanded {
                return brands.count + 1
            } else {
                return 1
            }
            
        } else {
            return filteredTemplates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TemplateCell.ID, for: indexPath) as! TemplateCell
        cell.lblDesc.text = ""
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                if row > 0 {
                    cell.lblTitle.text = "BRAND: " + brands[row - 1]!.name!.uppercased()
                } else {
                    if let name = brand?["name"] {
                        cell.lblTitle.text = "brand: \(name ?? "")".uppercased()
                    }
                }
                
                if filteredTemplates.count == 0, cell.lblTitle.text?.count ?? 0 > 0{
                    cell.lblTitle.text = cell.lblTitle.text! + " ( not found )"
                }
            } else {
                let item = brands[indexPath.row - 1]
                cell.lblTitle.text = item?.name
            }
//            cell.lblDesc.text = item?.content?.withoutHtml.replacingOccurrences(of: "\n", with: "")
        } else {
            let item = filteredTemplates[indexPath.row]
            cell.lblTitle.text = item?.name
            cell.lblDesc.text = item?.content?.withoutHtml.replacingOccurrences(of: "\n", with: "")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                expanded = !expanded
                tableView.reloadData()
            } else {
                expanded = false
                row = indexPath.row
                section = indexPath.section
                
                if let brandId = self.brands[row-1]?.id {
                    self.filteredTemplates = self.templates.filter { $0?.brandId ==  brandId }
                }
                
                tableView.reloadData()
            }
            
        } else {
            templateIndex = indexPath.row
            let item = templates[indexPath.row]
            templateView.attributedText = item?.content?.convertHtml()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        } else {
            return 60
        }
    }
    
}
