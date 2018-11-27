//
//  TagListView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/24/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ErxesTagView: UIView {

    var tagViews: [ErxesTagLabel] = []
    

    
    func removeAllTags() {
        
        for view in self.subviews {
            
            view.removeFromSuperview()
        }
        tagViews.removeAll()
        arrangeTags()
    }
    
    func addTagViews(tagViews:[ErxesTagLabel]) {
        for tagview in tagViews {
            self.tagViews.append(tagview)
        }
        arrangeTags()
    }
    
    private func createNewTagView(title:String, backgroundColor:UIColor) -> ErxesTagLabel {
        let tagview = ErxesTagLabel(title: title, backgroundColor: backgroundColor)
        return tagview
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangeTags()
    }
    
    private func arrangeTags() {
        let maxWidth = self.frame.size.width
        var totalWidth:CGFloat = 0
        var x:CGFloat = 0
        for (index, tagview) in tagViews.enumerated() {
            totalWidth = tagview.frame.size.width + totalWidth
            if index == 0 {
                self.addSubview(tagview)
            } else {
            
                  
                  let prevItemWidth = tagViews[index-1].frame.size.width
                  x = prevItemWidth + x + 5
                    tagview.frame.origin = CGPoint(x: x , y: 0)
                if (x + tagview.frame.size.width) > maxWidth && maxWidth != 0 {

                    let remainingCount = self.tagViews.count - index
                    tagview.text = String(format: "+%i", remainingCount)
                    tagview.backgroundColor = UIColor.GRAY_COLOR
                    let size = tagview.intrinsicContentSize
                    tagview.frame = CGRect(x: x, y: 0, width: size.width+10, height: 18)
                    self.addSubview(tagview)
                    self.tagViews.removeAll()
                  
                    return
                } else {
                    self.addSubview(tagview)
                }
                
                
            }
          
        }
        
        
    }

}
