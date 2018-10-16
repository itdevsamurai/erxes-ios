//
//  Filter_TableView.swift
//  erxes-ios
//
//  Created by alternate on 10/16/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 50, 0, 0))
    }
}

extension FilterController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        switch indexPath.section {
        case channel:
            if row > 0 {
                filterOptions.channel = channels.filter{$0.name==list[row-1]}[0]
            }
            break
            
        case date:
            let controller = DateFilterController()
            controller.delegate = self
            if indexPath.row == 0 {
                controller.isBeginDate = true
            } else {
                controller.isBeginDate = false
            }
            
            let currentCell = tableView.cellForRow(at: indexPath)
            self.presentViewControllerAsPopover(viewController: controller, from: currentCell!)
            return
            
        case status:
            
            switch statusArray[row] {
            case "Resolved":
                self.filterOptions.unassigned = ""
                self.filterOptions.participating = ""
                self.filterOptions.status = "closed"
                break
            case "Unassigned":
                self.filterOptions.unassigned = "true"
                self.filterOptions.participating = ""
                self.filterOptions.status = ""
                break
            case "Participating":
                self.filterOptions.unassigned = ""
                self.filterOptions.participating = "true"
                self.filterOptions.status = ""
                break
            default: break
            }
            statusValue = statusArray[row]
            //            filterOptions.status = statusArray[row]
            break
            
        case brand:
            if row > 0 {
                filterOptions.brand = brands.filter{$0.name==list[row-1]}[0]
            }
            break
            
        case integration:
            filterOptions.integrationType = integrations[row]
            break
            
        case tag:
            if row > 0 {
                filterOptions.tag = tags.filter{$0.name==list[row-1]}[0]
            }
            break
            
        default: break
            
        }
        
        tableView.reloadData()
        collapseSection(selectedSection)
        
        print(filterOptions)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == selectedSection {
            return itemCount(section: section)
        } else {
            return 0
        }
    }
    
    func itemCount(section:Int) -> Int {
        switch section {
        case channel:
            return list.count + 1
        case date:
            return 2
        case status:
            return statusArray.count
        case brand:
            return list.count + 1
        case integration:
            return integrations.count
        case tag:
            return list.count + 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        var cell = MyTableViewCell(style: .default, reuseIdentifier: "cell") as UITableViewCell
        
        //        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.font = UIFont.fontWith(type: .comfortaa, size: 13)
        cell.textLabel?.textColor = UIColor(hexString: "#1f9fe2")
        
        switch indexPath.section {
            
        case channel:
            if row == 0 {
                cell = InputCell(style: .default, reuseIdentifier: InputCell.ID)
                (cell as! InputCell).input.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
            } else {
                cell.textLabel?.text = list[indexPath.row - 1]
            }
        case date:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Begin date"
            } else {
                cell.textLabel?.text = "End date"
            }
            
        case status:
            cell.textLabel?.text = statusArray[row]
        case brand:
            if row == 0 {
                cell = InputCell(style: .default, reuseIdentifier: InputCell.ID)
                (cell as! InputCell).input.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
            } else {
                cell.textLabel?.text = list[indexPath.row - 1]
            }
        case integration:
            cell.textLabel?.text = integrations[indexPath.row]
        case tag:
            if row == 0 {
                cell = InputCell(style: .default, reuseIdentifier: InputCell.ID)
                (cell as! InputCell).input.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
            } else {
                cell.textLabel?.text = list[indexPath.row - 1]
            }
        default:
            cell.textLabel?.text = "text"
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = .white
        let line = UIView(frame: CGRect(x: 12, y: 0, width: Constants.SCREEN_WIDTH - 24, height: 1))
        line.backgroundColor = UIColor(hexString: "#eaeaea")
        view.addSubview(line)
        
        let lbl = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 42))
        lbl.text = sections[section]
        lbl.font = UIFont.fontWith(type: .comfortaaBold, size: 15)
        view.addSubview(lbl)
        view.tag = section
        
        let lblValue = UILabel(frame: CGRect(x: Constants.SCREEN_WIDTH - 275, y: 0, width: 200, height: 42))
        lblValue.text = sections[section]
        lblValue.font = UIFont.fontWith(type: .comfortaaBold, size: 12)
        lblValue.textColor = .gray
        lblValue.textAlignment = .right
        view.addSubview(lblValue)
        
        let iv = UIImageView(frame: CGRect(x: Constants.SCREEN_WIDTH - 70, y: 17, width: 20, height: 10))
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "ic_right_bracket")
        view.addSubview(iv)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(sectionSelected(_:)))
        view.addGestureRecognizer(tapGesture)
        lblValue.text = ""
        switch section {
        case channel:
            if let item = filterOptions.channel?.name {
                lblValue.text = item
            }
        case date:
            lblValue.text = filterOptions.startDate + " - " + filterOptions.endDate
        case status:
            lblValue.text = statusValue
        case brand:
            if let item = filterOptions.brand?.name {
                lblValue.text = item
            }
        case integration:
            lblValue.text = filterOptions.integrationType
        case tag:
            if let item = filterOptions.tag?.name {
                lblValue.text = item
            }
        default:
            lblValue.text = ""
        }
        
        return view
    }
    
    @objc func sectionSelected(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {
            
            if selectedSection >= 0 {
                let oldSection = selectedSection
                collapseSection(oldSection)
                if oldSection != section {
                    expandSection(section)
                }
            } else {
                expandSection(section)
            }
        }
    }
    
    func collapseSection(_ section:Int) {
        var indexes = [IndexPath]()
        let sectionSize = tableView.numberOfRows(inSection: section)
        for i in 0 ..< sectionSize {
            indexes.append(IndexPath(row: i, section: section))
        }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: indexes, with: .fade)
        selectedSection = -1
        tableView.endUpdates()
        list = []
        self.view.endEditing(true)
    }
    
    func expandSection(_ section:Int) {
        var indexes = [IndexPath]()
        let sectionSize = itemCount(section:section)
        for i in 0 ..< sectionSize {
            indexes.append(IndexPath(row: i, section: section))
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: .fade)
        selectedSection = section
        tableView.endUpdates()
    }
    
    func refreshSection(_ section:Int) {
        var indexes = [IndexPath]()
        let sectionSize = itemCount(section:section)
        for i in 0 ..< sectionSize {
            indexes.append(IndexPath(row: i, section: section))
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: .fade)
        selectedSection = section
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    @objc func inputChanged(_ sender:UITextField) {
        
        guard let value = sender.text else {
            return
        }
        
        tableView.beginUpdates()
        
        if list.count > 0 {
            var oldIndexes = [IndexPath]()
            for i in 1 ... list.count {
                oldIndexes.append(IndexPath(row: i, section: selectedSection))
            }
            tableView.deleteRows(at: oldIndexes, with: .fade)
            list = []
        }
        
        if value.count > 0 {
            
            var tmp = [String]()
            
            switch selectedSection {
            case channel:
                tmp = channels.filter{$0.name.localizedCaseInsensitiveContains(value)}.map{$0.name}
            case brand:
                tmp = brands.filter{$0.name!.localizedCaseInsensitiveContains(value)}.map{$0.name!}
            case tag:
                tmp = tags.filter{$0.name!.localizedCaseInsensitiveContains(value)}.map{$0.name!}
            default:
                tmp = []
            }
            
            if tmp.count > 0 {
                var newIndexes = [IndexPath]()
                for i in 1 ... tmp.count {
                    newIndexes.append(IndexPath(row: i, section: selectedSection))
                }
                tableView.insertRows(at: newIndexes, with: .fade)
                list = tmp
            }
        }
        tableView.endUpdates()
    }
}
