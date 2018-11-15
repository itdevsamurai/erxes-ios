//
//  AvatarCell.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 9/4/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit

class ChatBaseCell: UICollectionViewCell {
    
    var inited = false
    
    public struct ViewModel {
        var id:String
        var date:Int
        var text:String
        var avatar:String
        var isIncoming = false
    }
    
    var customer:EModel?
    
    var viewModel:MessageDetail? {
        didSet {
            self.updateView()
        }
    }
    
    var ivAvatar:UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var lblDate:UILabel = {
        let lbl = UILabel()
        lbl.font = Font.regular(10)
        lbl.textColor = .gray
        return lbl
    }()
    
    var tvText:UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = .ERXES_COLOR
        view.textColor = .white
        view.layer.cornerRadius = 10
        view.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        return view
    }()
    
    func isIncoming() -> Bool {
        return viewModel?.userId == ErxesUser.sharedUserInfo()._id
    }
    
    func updateView() {
        if let avatar = viewModel?.user?.details?.avatar {
            ivAvatar.sd_setImage(with: URL(string: avatar), placeholderImage:#imageLiteral(resourceName: "ic_avatar"))
        } else if viewModel?.customerId != nil, let customer = customer {
            ivAvatar.setAvatarOfCustomer(customer: customer)
        } else {
            ivAvatar.image = #imageLiteral(resourceName: "ic_avatar")
        }
        
        let date = viewModel?.createdAt?.dateFromUnixTime()
        let now = date?.hourMinutes!
        lblDate.text = now!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if inited { return }
        layoutView()
        inited = true
    }
    
    var edgeView:UIView = {
        let view = UIView()
        view.backgroundColor = .ERXES_COLOR
        return view
    }()
    
    open func commonInit() {
        self.contentView.addSubview(edgeView)
        self.contentView.addSubview(ivAvatar)
        self.contentView.addSubview(lblDate)
        self.contentView.addSubview(tvText)
    }
    
    open func layoutView() {
    }
    
    static func calculateHeight(_ item:MessageDetail) -> CGFloat {
        let tv = UITextView()
        
        var options = [NSAttributedStringKey:Any]()
        options[NSAttributedStringKey.font] = Font.regular(13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 0
        options[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        
        guard var content = item.content else {
            return 50
        }
        
//        content = content.replacingOccurrences(of: "<p>", with: "")
//        content = content.replacingOccurrences(of: "</p>", with: "")
        
        let str = content.convertHtml()
        
        str.addAttributes(options, range: NSMakeRange(0, str.length))
        if str.attributedSubstring(from: NSMakeRange(str.length-1, 1)).string == "\n" {
            str.deleteCharacters(in: NSMakeRange(str.length-1, 1))
        }
        tv.attributedText = str
        
        let h = tv.sizeThatFits(CGSize(width: Constants.SCREEN_WIDTH - 100, height: 10000)).height + 22
        if h < 50 {
            return 50
        } else {
            return h
        }
    }
}
