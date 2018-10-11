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

class ContactDetailController: DTPagerController {

    private var titles:[String] = ["Customer","Activity","Notes","Conversation"]

    var contactId:String = String()
    var contactName = String()
//    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titles[0]
        configureViews()
    }
    
    func configureViews(){
        self.font = UIFont.fontWith(type: .comfortaa, size: 14)
        self.selectedFont = UIFont.fontWith(type: .comfortaaBold, size: 14)
        self.selectedTextColor = .ERXES_COLOR
        self.scrollIndicator.backgroundColor = .ERXES_COLOR
        let customerController = CustomerProfileController(_id: self.contactId)
        customerController.title = "Customer"
        let activityController = ActivityController(id: self.contactId, name: self.contactName)
        activityController.title = "Activity"
        let noteController = NoteController()
        noteController.title = "Notes"
        let conversationController = ConversationsController()
        conversationController.title = "Conversation"
//        let segmentedControl = HMSegmentedControl(sectionTitles: titles )
        let controllers = [customerController,activityController,noteController,conversationController]
        self.viewControllers = controllers
//        self.pageSegmentedControl = segmentedControl!
        self.delegate = self
    }

    init(contactId:String, name:String) {

        let segmentedControl = HMSegmentedControl(sectionTitles: titles )
        
       super.init(viewControllers:[])
        self.pageSegmentedControl = segmentedControl!
        self.contactId = contactId
        self.contactName = name
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

    

}

extension ContactDetailController: DTPagerControllerDelegate {
    func pagerController(_ pagerController: DTPagerController, didChangeSelectedPageIndex index: Int) {
        self.title = titles[index]
    }
}

//extension ContactDetailController:SwipeMenuViewDelegate
//
//extension ContactDetailController:SwipeMenuViewDataSource

extension HMSegmentedControl: DTSegmentedControlProtocol {
    
    public func setImage(_ image: UIImage?, forSegmentAt segment: Int) {
        // Custom page control does not support
    }
    
    public func setTitle(_ title: String?, forSegmentAt segment: Int) {
        // Custom page control does not support
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
