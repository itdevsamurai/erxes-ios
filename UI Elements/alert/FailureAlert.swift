//
//  FailureAlert.swift
//  erxes-ios
//
//  Created by soyombo bat-erdene on 1/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class FailureAlert: UIView, Modal {

    var backgroundView = UIView()
    var dialogView = UIView()
    var closeButton = UIButton()
    var handler: (() -> Void)?

    convenience init(message: String) {
        self.init(frame: UIScreen.main.bounds)

        initialize(message: message)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func initialize(message: String) {



        dialogView.clipsToBounds = true
        backgroundView.frame = frame
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)


        let headerView = UIImageView(frame: CGRect(x: 89, y: 20, width: 72, height: 36))

        headerView.contentMode = .scaleAspectFill


        let img = #imageLiteral(resourceName: "Logo")
        headerView.image = img.withRenderingMode(.alwaysTemplate)
        headerView.tintColor = UIColor.ERXES_COLOR
        dialogView.addSubview(headerView)

        let messageLabel = UILabel()
        messageLabel.font = UIFont.fontWith(type: .light, size: 14)
        messageLabel.textColor = UIColor.ERXES_COLOR
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        dialogView.addSubview(messageLabel)
        let labelHeight = self.heightForView(text: message, font: UIFont.fontWith(type: .light, size: 14), width: 210)
        messageLabel.frame = CGRect(x: 20, y: 70, width: 210, height: labelHeight)

        let dialogViewHeight = 20 + headerView.frame.height + 8 + labelHeight + 8 + 20

        dialogView.frame.origin = CGPoint(x: frame.width / 2 - 125, y: frame.height)
        dialogView.frame.size = CGSize(width: 250, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 8
        dialogView.dropShadow(color: UIColor.ERXES_COLOR, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        addSubview(dialogView)
        dialogView.clipsToBounds = false
        closeButton = UIButton(frame: CGRect(x: 230, y: -20, width: 40, height: 40))
        closeButton.setImage(UIImage.erxes(with: .cancel, textColor: UIColor.ERXES_COLOR), for: .normal)
        closeButton.backgroundColor = .white
        closeButton.layer.borderWidth = 1.0
        closeButton.layer.borderColor = UIColor.ERXES_COLOR.cgColor
        closeButton.layer.cornerRadius = 20
        closeButton.clipsToBounds = true
        closeButton.isHidden = false
        closeButton.addTarget(self, action: #selector(closeAction(sender:)), for: .touchUpInside)
        dialogView.addSubview(closeButton)

    }

    @objc func closeAction(sender: UIButton) {
        dismiss(animated: true)

        if let handle = handler {
            handle()
        }
    }

    @objc func didTappedOnBackgroundView() {

        dismiss(animated: true)
        if let handle = handler {
            handle()
        }
    }

}


