//
//  LineProgressView.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 9/27/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

class LineProgressView: UIView {

    var isAnimating = false
    private var progressBar = UIView()
    var bgColor: UIColor = .white
    var progressColor: UIColor = .ERXES_COLOR
    
 
    public init(){
        super.init(frame:CGRect.zero)
        progressBar.backgroundColor = self.progressColor
        self.backgroundColor = self.bgColor
        print("INIT")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let topController = self.getTopViewController()
        self.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(4)
            make.top.equalTo((topController?.topLayoutGuide.snp.bottom)!)
        }
        
        self.progressBar.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func show(){
        if self.superview != nil {
            return
        }
        
        if let topController = self.getTopViewController() {
            let superView: UIView = topController.view
            superView.addSubview(self)
            self.layoutSubviews()
        }
        
    }
    
    func startAnimation(){
        self.show()
        if !isAnimating{
            self.isAnimating = true
            let topController = self.getTopViewController()
            UIView.animate(withDuration: 0.5, delay:0, options: [], animations: {
                self.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(4)
                    make.top.equalTo((topController?.topLayoutGuide.snp.bottom)!)
                }
            }, completion: { animationFinished in
                self.addSubview(self.progressBar)
                self.configureAnimation()
            })
        }
    }
    
    func stopAnimation(){
        self.isAnimating = false
        UIView.animate(withDuration: 0.5, animations: {
            self.snp.makeConstraints({ (make) in
                make.height.equalTo(0)
            })
        })
    }
    
    private func configureAnimation(){
        guard let superview = self.superview else {
            stopAnimation()
            return
        }
        
        self.progressBar.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(0)
            make.height.equalTo(4)
        }
       
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.progressBar.snp.makeConstraints({ (make) in
                    make.height.equalTo(4)
                    make.width.equalTo(Constants.SCREEN_WIDTH*0.7)
                })
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.progressBar.snp.makeConstraints({ (make) in
                    make.height.equalTo(4)
                    make.width.equalTo(0)
                    make.top.equalTo(0)
                    make.left.equalTo(superview.frame.size.width)
                })
            })
            
        }) { (completed) in
            if (self.isAnimating){
                self.configureAnimation()
            }
        }
    }
    
    fileprivate func getTopViewController() -> UIViewController? {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}
