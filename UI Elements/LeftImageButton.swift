//
//  LeftButtonImage.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/12/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class LeftImageButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
//        if imageView != nil {
//            contentHorizontalAlignment = .left
//            let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
//            let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
//            titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
//        }
//
        if let imageWidth = self.imageView?.frame.width {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, imageWidth, 0, -imageWidth);
        }
        
        if let titleWidth = self.titleLabel?.frame.width {
            let spacing = titleWidth
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing, 0, 0);
        }
    }
    


}


//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    CGRect frame = [super imageRectForContentRect:contentRect];
//    CGFloat imageWidth = frame.size.width;
//    CGRect titleRect = CGRectZero;
//    titleRect.size = [[self titleForState:self.state] sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
//    titleRect.origin.x = (self.frame.size.width - (titleRect.size.width + imageWidth)) / 2.0 + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
//    frame.origin.x = titleRect.origin.x + titleRect.size.width - self.imageEdgeInsets.right + self.imageEdgeInsets.left;
//    return frame;
//    }
//
//    - (CGRect)titleRectForContentRect:(CGRect)contentRect {
//        CGFloat imageWidth = [self imageForState:self.state].size.width;
//        CGRect frame = [super titleRectForContentRect:contentRect];
//        frame.origin.x = (self.frame.size.width - (frame.size.width + imageWidth)) / 2.0 + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
//        return frame;
//}
