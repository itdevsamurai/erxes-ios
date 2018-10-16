//
//  FilterControllerOld.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 6/11/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import SnapKit
protocol FilterDelegate: class  {
    func passFilterOptions(options:FilterOptions)
}

class FilterController: UIViewController {
    
    weak var delegate: FilterDelegate?
    var filterOptions = FilterOptions()
    
    let channel = 0
    let date = 1
    let status = 2
    let brand = 3
    let integration = 4
    let tag = 5
    
    let sections = ["Channel","Date","Status","Brand","Integration","Tag"]
    let dates = ["Begin date:","End date:"]
    let integrations = ["messenger","twitter","facebook","form"]
    let statusArray = ["Unassigned","Participating","Resolved"]
//    var channels = ["channel 1","channel 2","channel 3","channel 4","channel 5","channel 6","channel 7"]
    var statusValue = ""
    var channels = [ChannelDetail]()
    
    var brands = [BrandDetail]()
    
    var tags = [TagDetail]()
    
    var list = [String]()
    
    var selectedSection = -1
    
    var root: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    var tableView:UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTags()
        getBrands()
        getChannels()
        
        configureView()
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, delay: 0.4, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor(hexString: "#000000", alpha: 0.6)
        }, completion:nil)
    }
    
    override func viewDidLayoutSubviews() {
        layoutView()
    }
    
    func configureHeader() {
        let rightButton = UIButton()
        rightButton.setTitle("Done", for: .normal)
        rightButton.titleLabel?.font = UIFont.fontWith(type: .comfortaaBold, size: 14)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
        self.root.addSubview(rightButton)
        
        let lbl = UILabel()
        lbl.text = "FILTER"
        lbl.font = UIFont.fontWith(type: .comfortaaBold, size: 15)
        lbl.textAlignment = .center
        self.root.addSubview(lbl)
        
        let btnClose = UIButton()
//        btnClose.setImage(#imageLiteral(resourceName: "ic_xMark"), for: .normal)
        btnClose.setTitle("Clear", for: .normal)
        btnClose.titleLabel?.font = UIFont.fontWith(type: .comfortaaBold, size: 14)
        btnClose.setTitleColor(.black, for: .normal)
        btnClose.addTarget(self, action: #selector(clear(sender:)), for: .touchUpInside)
        root.addSubview(btnClose)
        
        lbl.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.centerX.equalTo(root.snp.centerX)
            make.height.equalTo(60)
        }
        
        rightButton.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-50)
        }
        
        btnClose.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(40)
        }
    }
    
    @objc func close(sender:UIButton){
        self.dismiss(animated: true) {
            self.delegate?.passFilterOptions(options: self.filterOptions)
        }
    }
    
    @objc func clear(sender:UIButton){
        tableView.reloadData()
        self.filterOptions.removeAll()
        tableView.layoutSubviews()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureView() {
        self.view.addSubview(root)
        root.addSubview(tableView)
        configureHeader()
    }
    
    func layoutView() {
        root.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
    }
}

class MyTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 50, 0, 0))
    }
}

extension FilterController: DateDelegate {
    
    func setDate(options: FilterOptions, isBeginDate: Bool) {
        if isBeginDate{
            self.filterOptions.startDate = options.startDate
//            let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! FilterCell
//            cell.value.text = self.filterOptions.startDate
        }else{
            self.filterOptions.endDate = options.endDate
//            let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! FilterCell
//            cell.value.text = self.filterOptions.endDate
        }
        tableView.reloadData()
        collapseSection(selectedSection)
    }
    
    func presentViewControllerAsPopover(viewController: UIViewController, from: UIView) {
        if let presentedVC = self.presentedViewController {
            if presentedVC.nibName == viewController.nibName {
                // The view is already being presented
                return
            }
        }
        // Specify presentation style first (makes the popoverPresentationController property available)
        viewController.modalPresentationStyle = .popover
        let viewPresentationController = viewController.popoverPresentationController
        if let presentationController = viewPresentationController {
            presentationController.delegate = self
            presentationController.permittedArrowDirections = [.up]
            presentationController.sourceView = from
            presentationController.sourceRect = from.bounds
        }
        viewController.preferredContentSize = CGSize(width: Constants.SCREEN_WIDTH, height: 300)
        
        self.present(viewController, animated: true, completion: nil)
    }
}

extension FilterController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
