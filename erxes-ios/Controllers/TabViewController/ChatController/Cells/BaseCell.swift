//
//  AvatarCell.swift
//  erxes-ios
//
//  Created by alternate on 9/4/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
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
        lbl.font = UIFont(name: "Montserrat-Regular", size: 11)
        lbl.textColor = .gray
        return lbl
    }()
    
    var tvText:UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = .ERXES_COLOR
        view.textColor = .white
        view.layer.cornerRadius = 5
        view.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return view
    }()
    
    func isIncoming() -> Bool {
        return viewModel?.userId == ErxesUser.sharedUserInfo()._id
    }
    
    func updateView() {
        
        if let avatar = viewModel?.user?.details?.avatar {
            ivAvatar.sd_setImage(with: URL(string: avatar), placeholderImage:#imageLiteral(resourceName: "avatar.png"))
        } else {
            ivAvatar.image = #imageLiteral(resourceName: "avatar.png")
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
        tvText.dropShadow(color: .black, opacity: 0.5, offSet: CGSize(width: 3, height: 3), radius: 5, scale: false)
    }
    
    open func layoutView() {
    }
    
    static func calculateHeight(_ item:MessageDetail) -> CGFloat {
        let tv = UITextView()
        
        if let str = item.content?.convertHtml(){
            str.addAttribute(NSAttributedStringKey.font, value: UIFont.fontWith(type: .regular, size: 14), range: NSMakeRange(0, str.length))
            tv.attributedText = str
        }
        
        let h = tv.sizeThatFits(CGSize(width: DEVICE_WIDTH, height: 10000)).height + 20
        if h < 48 {
            return 48
        } else {
            return h
        }
    }
}
