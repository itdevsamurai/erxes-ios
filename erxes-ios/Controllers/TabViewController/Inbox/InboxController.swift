//
//  InboxController.swift
//  Erxes.io
//
//  Created by soyombo bat-erdene on 2/20/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import SDWebImage
import Shimmer
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

class InboxController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate



    var total = Int()
    var loader: ErxesLoader = {
        let loader = ErxesLoader(frame: CGRect(x: Constants.SCREEN_WIDTH/2-25, y: Constants.SCREEN_HEIGHT/2-25, width: 50, height: 50))
        loader.lineWidth = 3
        return loader
    }()
    var timer: Timer!
    var topOffset: CGFloat = 0.0
    var shimmer: FBShimmeringView!
    var conversationLimit = 10
    


    var robotView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = #imageLiteral(resourceName: "robot-2")
        imageview.contentMode = .scaleAspectFit
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.fontWith(type: .light, size: 14)
        label.text = "There is no message."
        label.textAlignment = .center
        imageview.addSubview(label)
        imageview.clipsToBounds = false

        return imageview
    }()

    var filterListView: TagListView = {
        let tagListView = TagListView()
        tagListView.tagBackgroundColor = UIColor.ERXES_COLOR
        tagListView.cornerRadius = 6
        tagListView.textFont = UIFont(name: "Montserrat-Light", size: 14)!
        tagListView.textColor = .white
        tagListView.clipsToBounds = false
//        tagListView.removeButtonIconSize = 4
        tagListView.removeIconLineWidth = 1
        tagListView.removeIconLineColor = .white
        tagListView.enableRemoveButton = true
        return tagListView
    }()


    let gql = LiveGQL(socket: Constants.SUBSCRITION_ENDPOINT)

    func configLive() {
        gql.delegate = self
    }

    func subscribe(id: String) {

        gql.subscribe(graphql: "subscription{conversationsChanged(customerId:\"\(id)\"){type,customerId}}", variables: nil, operationName: nil, identifier: "change")

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

            //
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


    @objc func navigateFilter() {
//        let nav = NavigationController()
        let controller = FilterController()
        controller.delegate = self
        if self.options != nil {
            controller.filterOptions = self.options!
        }
        controller.modalPresentationStyle = .overFullScreen
//        nav.viewControllers = [controller]
        self.present(controller, animated: true) {

        }
    }

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ErxesInboxCell.self, forCellReuseIdentifier: "ErxesInboxCell")
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor(hexString: "#d6d6d6")
        tableView.backgroundColor = .white
//        tableView.layer.cornerRadius = 6.0
        return tableView
    }()

    public var options: FilterOptions? = nil



    func configureViews() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        let leftImage = UIImage.erxes(with: .filter, textColor: UIColor.ERXES_COLOR, size: CGSize(width: 22, height: 22))
        
        let leftImage = #imageLiteral(resourceName: "ic_filter")
//        leftImage = leftImage.withRenderingMode(.alwaysTemplate)
        let leftButton = UIButton()
        leftButton.setImage(leftImage, for: .normal)
        leftButton.addTarget(self, action: #selector(navigateFilter), for: .touchUpInside)
//        leftButton.tintColor = UIColor.ERXES_COLOR
        let leftItem = UIBarButtonItem()
//        leftItem.tintColor = UIColor.ERXES_COLOR
        leftItem.customView = leftButton
//        leftItem.image = leftImage

        self.navigationItem.leftBarButtonItem = leftItem

        var rightImage = #imageLiteral(resourceName: "ic_search")
        rightImage = rightImage.withRenderingMode(.alwaysTemplate)
        let rightItem = UIBarButtonItem()
        rightItem.tintColor = UIColor.ERXES_COLOR
        rightItem.image = rightImage
//        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(robotView)
        robotView.isHidden = true
        filterListView.delegate = self
        self.view.addSubview(filterListView)

        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white


//        shimmer = FBShimmeringView()
//        shimmer.contentView = tableView
//        self.view.addSubview(shimmer)
//        shimmer.isShimmering = true
        self.view.addSubview(loader)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = ErxesUser.sharedUserInfo()

        topOffset = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 3

        self.title = "Inbox"
        self.view.backgroundColor = UIColor.INBOX_BG_COLOR
        self.configureViews()
        configLive()
        self.view.bringSubview(toFront: loader)
        self.getInbox()
//        getInbox()
//        getUnreadCount()

    }




    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        shimmer.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view.snp.left).offset(16)
//            make.right.equalTo(self.view.snp.right).inset(16)
//            make.top.equalTo(topLayoutGuide.snp.bottom).offset(3)
//            make.bottom.equalTo(self.view.snp.bottom).inset(3)
//        }

        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
        }

        filterListView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).inset(16)
            make.height.equalTo(65)
            make.top.equalTo(topOffset)
        }

        robotView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(30)
            make.right.equalTo(self.view.snp.right).inset(30)
            make.center.equalToSuperview()
        }

        robotView.subviews[0].snp.makeConstraints { (make) in
            make.right.left.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(robotView.snp.bottom)
        }

//        loader.snp.makeConstraints { (make) in
//            make.width.height.equalTo(50)
//            make.center.equalTo(self.view.snp.center)
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    func getLast() {

        let query = GetLastQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
            if let error = error {
              
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
            }

            if result?.data != nil {
                if let rslt = result?.data?.conversationsGetLast {
                    if self?.lastItem.count == 0 {
                        self?.lastItem = [rslt.fragments.objectDetail]
                    } else {
                        for item in (self?.lastItem)! {
                            if !item.isNew(to: rslt.fragments.objectDetail) {
                                self?.lastItem = [rslt.fragments.objectDetail]
                            }
                        }
                    }

                }

            }
        }
    }

    @objc func getInbox(limit: Int = 10) {
        if self.timer != nil {
            self.timer.invalidate()
        }
        loader.startAnimating()
        let query = ObjectsQuery()

        if options != nil {
            query.brandId = options?.brand?.id
            if options?.unassigned.count != 0 {
                query.unassigned = "true"
            }
            if options?.participating.count != 0 {
                query.participating = "true"
            }
            query.channelId = options?.channel?.id
            query.status = options?.status
            query.integrationType = options?.integrationType
            if options?.startDate.count != 0 {
                query.startDate = (options?.startDate)! + " 00:00"
            }

            if options?.endDate.count != 0 {
                query.endDate = (options?.endDate)! + " 00:00"
            }
            query.tag = options?.tag?.id

        }
        query.limit = limit

        appnet.fetch(query: query, cachePolicy: CachePolicy.fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {

                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
            }
            if result?.data != nil {
                if let allConversations = result?.data?.conversations {
                  
                    if allConversations.count == 0 {
                        self?.conversations.removeAll()
                        self?.tableView.reloadData()
                        self?.tableView.isHidden = true
                        self?.robotView.isHidden = false
                    } else {
                        self?.tableView.isHidden = false
                        self?.robotView.isHidden = true
                        self?.conversations = allConversations.map { ($0?.fragments.objectDetail)! }

//                    self?.shimmer.isShimmering = false
                        for conversation in (self?.conversations)! {
                            self?.subscribe(id: (conversation.customer?.id)!)
//                            self?.subscribe(id: conversation.id)

                        }
                    }

                    self?.loader.stopAnimating()
                    self?.tableView.reloadData()

                }
            }
        }
    }

    func getUnreadCount() {
        let query = UnreadCountQuery()
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
            if let error = error {
    
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
            }
            if result?.data != nil {
                if let count = result?.data?.conversationsTotalUnreadCount {
              
                    if count != 0 {
                        self?.tabBarItem.badgeColor = .red
                        self?.tabBarItem.badgeValue = String(format: "%i", count)
                    } else {
                        self?.tabBarItem.badgeValue = nil
                    }

                }
            }

        }

    }



    func getTimeComponentString(olderDate older: Date, newerDate newer: Date) -> (String?) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full

        let componentsLeftTime = Calendar.current.dateComponents([.minute, .hour, .day, .month, .weekOfMonth, .year], from: older, to: newer)

        let year = componentsLeftTime.year ?? 0
        if year > 0 {
            formatter.allowedUnits = [.year]
            return formatter.string(from: older, to: newer)
        }


        let month = componentsLeftTime.month ?? 0
        if month > 0 {
            formatter.allowedUnits = [.month]
            return formatter.string(from: older, to: newer)
        }

        let weekOfMonth = componentsLeftTime.weekOfMonth ?? 0
        if weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
            return formatter.string(from: older, to: newer)
        }

        let day = componentsLeftTime.day ?? 0
        if day > 0 {
            formatter.allowedUnits = [.day]
            return formatter.string(from: older, to: newer)
        }

        let hour = componentsLeftTime.hour ?? 0
        if hour > 0 {
            formatter.allowedUnits = [.hour]
            return formatter.string(from: older, to: newer)
        }

        let minute = componentsLeftTime.minute ?? 0
        if minute > 0 {
            formatter.allowedUnits = [.minute]
            return formatter.string(from: older, to: newer) ?? ""
        }

        return nil
    }

}

extension InboxController {
    func changeStatus(id:String, status:String){
        let mutation = ConversationsChangeStatusMutation(_ids: [id], status: status)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
                return
            }
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                self?.loader.stopAnimating()
            }
            if result?.data != nil {
                self?.getInbox(limit: (self?.conversationLimit)!)
            }
        }
        
    }
}

