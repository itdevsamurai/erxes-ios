//
//  ContactDetailController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/10/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import DTPagerController
import HMSegmentedControl

protocol ContactDelegate: class {
    func reloadData()
}

class ContactDetailController: DTPagerController {

    private var titles:[String] = ["Profile","Activity","Notes","Conversation"]
   
    var contactId:String = String()
    var contactName = String()
    var email = String()
    var logs = [LogData](){
        didSet{
            activityController.logs = self.logs
            noteController.notes = self.logs
            conversationController.conversations = self.logs
        }
    }
    var isCompany = Bool()
    
    var activityController = ActivityController()
    var noteController = NoteController()
    var conversationController = ConversationsController()
    var companyController = CompanyController()
    var customerController = CustomerProfileController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titles[0]
        configureViews()
        getActivityLog()
    }
    
    func configureViews(){
        
      
        
        self.font = UIFont.fontWith(type: .comfortaa, size: 14)
        self.selectedFont = UIFont.fontWith(type: .comfortaaBold, size: 14)
        self.selectedTextColor = .ERXES_COLOR
        self.scrollIndicator.backgroundColor = .ERXES_COLOR
        companyController = CompanyController(id: self.contactId)
        companyController.title = "Company"
        customerController = CustomerProfileController(_id: self.contactId)
        customerController.title = "Customer"
        activityController.contactName = self.contactName
        activityController.contactId = self.contactId
        activityController.title = "Activity"
        noteController.title = "Notes"
        noteController.contactId = self.contactId
        noteController.email = self.email
        noteController.delegate = self
        conversationController.title = "Conversation"
        conversationController.contactId = self.contactId
        conversationController.contactName = self.contactName
        
        var controllers = [UIViewController]()
        if isCompany {
           controllers =  [companyController,activityController,noteController,conversationController]
        }else{
            controllers =  [customerController,activityController,noteController,conversationController]
        }
        
        self.viewControllers = controllers
        self.delegate = self
        
        let rightItem: UIBarButtonItem = {
            var rightImage = UIImage.erxes(with: .edit, textColor: UIColor.TEXT_COLOR)
            var saveImage = UIImage.erxes(with: .user2, textColor: UIColor.TEXT_COLOR)
            rightImage = rightImage.withRenderingMode(.alwaysTemplate)
            saveImage = saveImage.withRenderingMode(.alwaysTemplate)
            let barButtomItem = UIBarButtonItem()
            let button = UIButton()
            button.setBackgroundImage(rightImage, for: .normal)
            button.setBackgroundImage(saveImage, for: .selected)
            button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
            barButtomItem.customView = button
            return barButtomItem
        }()
        rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
    }

    init(contactId:String, name:String, isCompany:Bool) {

        let segmentedControl = HMSegmentedControl(sectionTitles: titles )
        
       super.init(viewControllers:[])
        self.pageSegmentedControl = segmentedControl!
        self.contactId = contactId
        self.contactName = name
        self.isCompany = isCompany
       
    }
    
    override func setUpSegmentedControl(viewControllers: [UIViewController]) {
        super.setUpSegmentedControl(viewControllers: viewControllers)
        perferredScrollIndicatorHeight = 0
        let segmentedControl = pageSegmentedControl as! HMSegmentedControl
        segmentedControl.selectionIndicatorColor = .ERXES_COLOR
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentedControl.selectionIndicatorHeight = 1
        segmentedControl.titleTextAttributes =  [
            NSAttributedStringKey.foregroundColor: UIColor.ERXES_COLOR,
            NSAttributedStringKey.font: UIFont.fontWith(type: .comfortaa, size: 13)
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    @objc func editAction(sender:UIButton) {
        if isCompany {
            companyController.editAction(sender: sender)
        }else{
           customerController.editAction(sender: sender)
        }
    }
    
    func getActivityLog(){
        self.logs.removeAll()
        if !self.isCompany {
        let query = ActivityLogsCustomerQuery(_id: contactId)
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
            }
            
            if result?.data != nil {
                if let logDatas = result?.data?.activityLogsCustomer {
                    let logsTmp  = logDatas.map { ($0?.fragments.logData)! }
                    for log in logsTmp {
                        if log.list.count != 0 {
                            self?.logs.append(log)
                        }
                    }
                }
            }
        }
        }else{
            let query = ActivityLogsCompanyQuery(_id: contactId)
            appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
                if let error = error {
                    print(error.localizedDescription)
                    let alert = FailureAlert(message: error.localizedDescription)
                    alert.show(animated: true)
                    return
                }
                
                if let err = result?.errors {
                    let alert = FailureAlert(message: err[0].localizedDescription)
                    alert.show(animated: true)
                }
                
                if result?.data != nil {
                    if let logDatas = result?.data?.activityLogsCompany {
                        let logsTmp  = logDatas.map { ($0?.fragments.logData)! }
                        for log in logsTmp {
                            if log.list.count != 0 {
                                self?.logs.append(log)
                            }
                        }
                    }
                }
            }
        }
    }


}

extension ContactDetailController: DTPagerControllerDelegate {
    func pagerController(_ pagerController: DTPagerController, didChangeSelectedPageIndex index: Int) {
        self.title = titles[index]
        if index == 0 {
            let rightItem: UIBarButtonItem = {
                var rightImage = UIImage.erxes(with: .edit, textColor: UIColor.TEXT_COLOR)
                var saveImage = UIImage.erxes(with: .user2, textColor: UIColor.TEXT_COLOR)
                rightImage = rightImage.withRenderingMode(.alwaysTemplate)
                saveImage = saveImage.withRenderingMode(.alwaysTemplate)
                let barButtomItem = UIBarButtonItem()
                let button = UIButton()
                button.setBackgroundImage(rightImage, for: .normal)
                button.setBackgroundImage(saveImage, for: .selected)
                button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
                barButtomItem.customView = button
                return barButtomItem
            }()
            rightItem.tintColor = UIColor.white
            self.navigationItem.rightBarButtonItem = rightItem
        }else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
   
}



extension HMSegmentedControl: DTSegmentedControlProtocol {
    
    public func setImage(_ image: UIImage?, forSegmentAt segment: Int) {
      
    }
    
    public func setTitle(_ title: String?, forSegmentAt segment: Int) {

    }
    
    public func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState) {
        if state == UIControlState.normal {
            titleTextAttributes = attributes
        }
        else if state == UIControlState.selected {
            selectedTitleTextAttributes = attributes
        }
    }
    
}

extension ContactDetailController: ContactDelegate {
   
    
    func reloadData() {
        self.getActivityLog()
    }
}
