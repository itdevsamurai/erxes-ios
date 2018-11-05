//
//  LoginControllerUI.swift
//  erxes-ios
//
//  Created by alternate on 10/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit

class LoginControllerUI:ViewController {
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var isLogin = Bool()
    
    let innerCircle = CAShapeLayer()
    let outerCircle = CAShapeLayer()
    
    let checkBox: UIButton = {
        let checkButton = UIButton()
        
        checkButton.setImage(UIImage.erxes(with: .check, textColor: .white), for: .selected)
        checkButton.setImage(UIImage(), for: .normal)
        checkButton.alpha = 1.0
//        checkButton.addTarget(self, action: #selector(onCheckBoxPress(_:)), for: .touchUpInside)
        checkButton.layer.borderColor = UIColor.white.cgColor
        checkButton.layer.borderWidth = 1.0
        return checkButton
    }()
    
    let rememberMeLabel: UILabel = {
        let rememberMe = UILabel()
        rememberMe.text = "remember me"
        rememberMe.textColor = .white
        rememberMe.font = Font.light(12)
        rememberMe.tag = 200
        rememberMe.alpha = 1.0
        rememberMe.textAlignment = .right
        return rememberMe
    }()
    
    
    var mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ic_mail")
        imageView.alpha = 1.0
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .GRAY_COLOR
        label.font = Font.regular(28)
        label.text = "Welcome !"
        label.alpha = 0.0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let blueOrb: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "blueOrb"))
        return imageView
    }()
    
    let orangeOrb: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "orangeOrb"))
        return imageView
    }()
    
    
    
    let emailField: MyTextField = {
        let field = MyTextField()
        field.placeholder = "Email"
        field.attributedPlaceholder = NSAttributedString(string: "Email",
                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.LIGHT_GRAY_COLOR])
        field.alpha = 0.0
        field.keyboardType = .emailAddress
        
        return field
    }()
    
    let passwordField: MyTextField = {
        let field = MyTextField()
        field.placeholder = "Password"
        
        field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                         attributes: [NSAttributedStringKey.foregroundColor: UIColor.LIGHT_GRAY_COLOR])
        field.isSecureTextEntry = true
        field.alpha = 0.0
        return field
    }()
    
    let signInButton: MyButton = {
        let button = MyButton()
        
        button.setTitle("Login", for: .normal)
        button.alpha = 0.0
        
        return button
    }()
    
    let innerCircleCenter = UIView()
    let outerCircleCenter = UIView()
    
    override func prepareView() {
        self.view.addSubview(containerView)
        
        containerView.addSubview(mailImageView)
        containerView.addSubview(welcomeLabel)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            welcomeLabel.text = "Welcome back !"
        } else {
            welcomeLabel.text = "Welcome !"
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(signInButton)
        containerView.addSubview(blueOrb)
        containerView.addSubview(orangeOrb)
        if let cachedEmail = UserDefaults.standard.string(forKey: "cachedEmail") {
            print(cachedEmail)
            emailField.text = cachedEmail
            checkBox.isSelected = true
        }
    }
    
    override func layoutView() {
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(64)
            make.right.equalTo(self.view.snp.right).inset(64)
            make.height.equalTo(480)
            make.top.equalTo(view.snp.top).offset(98)
            if Constants.SCREEN_WIDTH == 320 {
                make.top.equalTo(view.snp.top).offset(40)
            }
            
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.left.right.bottom.equalToSuperview()
            
        }
        
        
        passwordField.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.signInButton.snp.top).offset(-20)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.bottom.equalTo(passwordField.snp.top).offset(-20)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(emailField.snp.top).offset(-40)
        }
        
        mailImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(74)
            make.bottom.equalTo(welcomeLabel.snp.top).offset(-98)
        }
        
        
        blueOrb.snp.makeConstraints { (make) in
            make.center.equalTo(mailImageView.snp.center).offset(-91)
        }
        
        orangeOrb.snp.makeConstraints { (make) in
            make.center.equalTo(mailImageView.snp.center).offset(58)
        }
    }
    
    @objc func drawCircleOfDots() {
        let frame = mailImageView.bounds
        let centerView = UIView()
        let centerView2 = UIView()
        centerView.frame = mailImageView.bounds
        centerView2.frame = mailImageView.bounds
        
        mailImageView.insertSubview(centerView, at: 0)
        mailImageView.insertSubview(centerView2, at: 1)
        innerCircle.path = UIBezierPath.init(roundedRect: CGRect(x: frame.origin.x - 45, y: frame.origin.y - 45, width: frame.width + 90, height: frame.height + 90), cornerRadius: (frame.width + 90) / 2).cgPath
        innerCircle.fillColor = UIColor.clear.cgColor
        innerCircle.strokeColor = UIColor.init(hexString: "e9e9e9")?.cgColor
        innerCircle.lineWidth = 1
        innerCircle.lineDashPattern = [5, 5]
        innerCircle.strokeEnd = 0
        centerView2.transform = CGAffineTransform(rotationAngle: 135 * CGFloat.pi / 180)
        centerView2.layer.addSublayer(innerCircle)
        
        let outerFrame = CGRect(x: frame.origin.x - 90, y: frame.origin.y - 90, width: frame.width + 180, height: frame.height + 180)
        let path = UIBezierPath.init(roundedRect: outerFrame, cornerRadius: (frame.width + 180) / 2)
        
        
        outerCircle.path = path.cgPath
        outerCircle.fillColor = UIColor.clear.cgColor
        outerCircle.strokeColor = UIColor.init(hexString: "e9e9e9")?.cgColor
        outerCircle.lineWidth = 1
        outerCircle.lineDashPattern = [5, 5]
        outerCircle.strokeEnd = 0
        centerView.transform = CGAffineTransform(rotationAngle: -45 * CGFloat.pi / 180)
        
        centerView.layer.addSublayer(outerCircle)
        
        
        animateAlongCircle(repeatCount: 1)
        animateCircle()
    }
    
    func animateCircle() {
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 1
        let animation1 = CABasicAnimation(keyPath: "strokeEnd")
        animation1.setValue("anim1", forKey: "id")
        animation1.delegate = self
        animation1.duration = 2
        animation1.fromValue = startAngle
        animation1.toValue = endAngle
        animation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.setValue("anim2", forKey: "id")
        animation2.delegate = self
        animation2.duration = 2
        animation2.fromValue = startAngle
        animation2.toValue = endAngle
        animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        outerCircle.strokeEnd = endAngle
        outerCircle.add(animation1, forKey: nil)
        innerCircle.strokeEnd = endAngle
        innerCircle.add(animation2, forKey: nil)
        self.view.isUserInteractionEnabled = true
    }
    
    func animateAlongCircle(repeatCount: Float) {
        self.view.isUserInteractionEnabled = false
        let innerCirclePath = UIBezierPath(arcCenter: mailImageView.center, radius: mailImageView.frame.width / 2 + 45, startAngle: .pi / 4, endAngle: .pi / 4 - 0.0174532925, clockwise: true)
        
        let innerAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        innerAnimation.duration = 2
        innerAnimation.repeatCount = repeatCount
        innerAnimation.path = innerCirclePath.cgPath
        
        let outerCirclePath = UIBezierPath(arcCenter: mailImageView.center, radius: mailImageView.frame.width / 2 + 90, startAngle: 5 * .pi / 4, endAngle: 5 * .pi / 4 - 0.0174532925, clockwise: true)
        
        let outerAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        outerAnimation.duration = 2
        outerAnimation.repeatCount = repeatCount
        outerAnimation.path = outerCirclePath.cgPath
        
        if repeatCount == 1.0 {
            innerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            outerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        }
        
        orangeOrb.layer.add(innerAnimation, forKey: nil)
        blueOrb.layer.add(outerAnimation, forKey: nil)
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: orangeOrb.center.x, y: -96)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: orangeOrb.frame.size.width, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        
        particleEmitter.emitterCells = [red, green, blue]
        
        //        orangeOrb.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        
        cell.contents = UIImage(named: "particle_confetti")?.cgImage
        return cell
    }
    
    func stopAnimation() {
        orangeOrb.layer.removeAllAnimations()
        blueOrb.layer.removeAllAnimations()
        self.view.isUserInteractionEnabled = true
    }
    
    func revealSubViews() {
        
        UIView.animate(withDuration: 0.5, animations: {
            for subView in self.containerView.subviews {
                
                if subView.alpha == 0.0 {
                    subView.alpha = 1.0
                }
            }
            self.view.layoutIfNeeded()
        }) { finished in
//            self.checkAuthentication()
        }
    }
    
}

extension LoginControllerUI: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim.value(forKey: "id") as! String == "anim1" {
            revealSubViews()
        }
        
    }
}
