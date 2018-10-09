//
//  FormCell.swift
//  erxes-ios
//
//  Created by alternate on 9/12/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

var css = "<style>table{border-collapse: collapse; color: #444; font-family:Roboto,Arial,sans-serif; font-size:12px; min-width:100%} table, th, td {border: 1px solid #eee; padding: 10px; } tr:nth-child(even) {background-color: #F7F8FC;font-weight:bold;}tr:first-child {text-align:center; font-size:11px; text-transform:uppercase; font-weight:bold;}</style>"

class FormCell: ChatBaseCell {
    
    static let ID = "FormCell"
    
    override func updateView() {
        super.updateView()
        let str = FormCell.createForm(item: viewModel!).convertHtml()
        tvText.attributedText = str
        tvText.backgroundColor = .clear
        tvText.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func layoutView() {
        tvText.snp.remakeConstraints { (make) in
            make.right.left.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    static func createForm(item:MessageDetail) -> String {
        
        if let formData = item.formWidgetData {
            
            if let rows = formData["data"] as? [[String:Any]] {
                
                var str = css
                
                var form = "<table>"
                form += "<tr><td>\(item.content!)</td></tr>"
                for row in rows {
                    form += "<tr><td>\(row["text"]!)</td></tr>"
                    form += "<tr><td>\(row["value"]!)</td></tr>"
                }
                
                form += "</table>"
                str += form
                
                return str
            }
        }
        return ""
    }
    
    static func calculateFormHeight(_ item:MessageDetail) -> CGFloat {
        let tv = UITextView()
        
        let str = FormCell.createForm(item: item).convertHtml()
        
        tv.attributedText = str
        
        let h = tv.sizeThatFits(CGSize(width: Constants.SCREEN_WIDTH, height: 10000)).height
        if h < 48 {
            return 48
        } else {
            return h
        }
    }
}
