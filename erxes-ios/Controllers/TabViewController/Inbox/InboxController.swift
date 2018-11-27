//
//  InboxController.swift
//  Erxes.io
//
//  Created by soyombo bat-erdene on 2/20/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit
import Apollo
import SDWebImage
import LiveGQL

public struct FilterOptions {

    public var status: String = ""
    public var channel: ChannelDetail? = nil
    public var brand: BrandDetail? = nil
    public var unassigned: String = ""
    public var participating: String = ""
    public var integrationType: String = ""
    public var tag: TagDetail? = nil
    public var startDate: String = ""
    public var endDate: String = ""
    mutating func removeAll() {
        self = FilterOptions()
    }

    public init() { }
}

class InboxController: InboxControllerUI {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var total = Int()
    var timer: Timer!
    var topOffset: CGFloat = 0.0
    var conversationLimit = 20
    var loading = false
    var lastPage = false
    var popBack = false
    
    let gql = LiveGQL(socket: Constants.SUBSCRITION_ENDPOINT)

    func configLive() {
        gql.delegate = self
    }

    func subscribe() {
        gql.subscribe(graphql: "subscription {conversationClientMessageInserted {_id,conversationId}}", variables: nil, operationName: nil, identifier: "conversationClientMessageInserted")
    }

    var conversations = [ObjectDetail]() {
        didSet {

        }
    }

    var lastItem = [ObjectDetail]() {
        didSet {
            let index = lastItem[0].findIndex(from: self.conversations)
      
            self.conversations.remove(at: index)
            self.conversations.insert(lastItem[0], at: 0)

            let updateIndexPath1 = IndexPath(row: index, section: 0)
            let updateIndexPath2 = IndexPath(row: 0, section: 0)

            self.tableView.beginUpdates()
            self.tableView.reloadRows(at: [updateIndexPath1, updateIndexPath2], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        }
    }

    var filterView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    var filterController = FilterController()

    @objc func navigateFilter() {

        filterController.delegate = self
        if self.options != nil {
            filterController.filterOptions = self.options!
        }
        filterController.modalPresentationStyle = .overFullScreen
        self.present(filterController, animated: true) {

        }
    }

    public var options: FilterOptions? = nil

    func configureViews() {
        filterButton.addTarget(self, action: #selector(navigateFilter), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = ErxesUser.sharedUserInfo()
        topOffset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 3
        self.title = "Inbox"
        self.view.backgroundColor = UIColor.INBOX_BG_COLOR
        self.configureViews()
        configLive()
        self.subscribe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if popBack {
            self.getInbox()
            popBack = false
        }
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
            presentationController.permittedArrowDirections = [.down, .up]
            presentationController.sourceView = from
            presentationController.sourceRect = from.bounds
        }
        viewController.preferredContentSize = CGSize(width: Constants.SCREEN_WIDTH, height: 300)

        self.present(viewController, animated: true, completion: nil)
    }

    @objc func refresh() {
        lastPage = false
        getInbox(limit: 20)
    }
}
