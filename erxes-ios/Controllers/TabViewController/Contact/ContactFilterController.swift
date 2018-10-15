//
//  ContactFilterController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/2/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit

protocol ContactFilterDelegate: class  {
    func passFilterOptions(options:ContactFilterOptions)
}

class ContactFilterController: UIViewController {

    weak var delegate: ContactFilterDelegate?
    var filterOptions = ContactFilterOptions()
    var isCustomer = Bool()
    var segment = 0
    var tag = 1
    var integration = 2
    var brand = 3
    var form = 4
    var lead = 5
    var lifecycle = 6

    var sections = ["Segments", "Tags", "Integrations", "Brand", "Form", "Lead status", "Lifecycle States"]
    var segments = [SegmentObj]()
    var tags = [TagDetail]()
    var brands = [BrandDetail]()
    var forms = [FormObj]()
    let integrations = ["messenger","twitter","facebook","form"]
    let leadStatus = ["New","Open","In Progress","Open Deal","Unqualified","Attempted to contact","Connected","Bad Timing"]
    let lifeCycleStates =  ["Subscriber","Lead","Marketing Qualified Lead","Sales Qualified Lead","Opportunity","Customer","Evangelist","Other"]
    var selectedSection = -1
    var list = [String]()
    var root: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()

    var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    func getSegments() {
        segments.removeAll()
        var type = "customer"
        if !isCustomer{
            type = "company"
        }
        let query = SegmentsQuery(contentType: type)
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
                if let segmentList = result?.data?.segments {
                    for segment in segmentList {
                        if (segment?.subOf.isNullOrEmpty)! {
                            self?.segments.append((segment?.fragments.segmentObj)!)
                        }
                    }
                    for subSegment in segmentList {
                        if !(subSegment?.subOf.isNullOrEmpty)! {
                            if let index = self?.segments.firstIndex(where: { $0.id == subSegment!.subOf }) {
                                self?.segments.insert((subSegment?.fragments.segmentObj)!, at: index + 1)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getTags(){
        var type = "customer"
        if !isCustomer{
            type = "company"
        }
        
        let query = TagsQuery(type: type)
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
                if let tagList = result?.data?.tags {
                    self?.tags = tagList.map({($0?.fragments.tagDetail)!})
                }
            }
        }
    }
    
    func getBrands(){
        let query = BrandsQuery()
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
                if let allBrands = result?.data?.brands {
                    self?.brands = allBrands.map { ($0?.fragments.brandDetail)! }
                }
            }
        }
    }
    
    func getForms(){
        let query = IntegrationsQuery()
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
                if let formList = result?.data?.integrations {
                    self?.forms = formList.map({($0?.fragments.formObj)!})
                }
            }
        }
    }
    
    convenience init(isCustomer: Bool?) {
        self.init()
        self.isCustomer = isCustomer!
        if !self.isCustomer{
//            ["Segments", "Tags", "Integrations", "Brand", "Form", "Lead status", "Lifecycle States"]
            self.sections = ["Segments","Tags","Lead Status","Lifecycle State","Brand"]
            self.segment = 0
            self.tag = 1
            self.lead = 2
            self.lifecycle = 3
            self.brand = 4
            self.integration = -1
            self.form = -1
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getSegments()
        getTags()
        getBrands()
        getForms()
        configureView()
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.3, delay: 0.4, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor(hexString: "#000000", alpha: 0.6)
        }, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        btnClose.setTitle("Clear", for: .normal)
        btnClose.titleLabel?.font = UIFont.fontWith(type: .comfortaaBold, size: 14)
        btnClose.setTitleColor(.black, for: .normal)
        btnClose.addTarget(self, action: #selector(clear(sender:)), for: .touchUpInside)
        root.addSubview(btnClose)

        lbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalTo(root.snp.centerX)
            make.height.equalTo(60)
        }

        rightButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-20)
        }

        btnClose.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(40)
        }
    }

    @objc func close(sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.passFilterOptions(options: self.filterOptions)
        }
    }

    @objc func clear(sender: UIButton) {
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

        tableView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
    }

    class MyTableViewCell: UITableViewCell {
        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 50, 0, 0))
            
            if ((self.imageView?.image) != nil) {
                let line = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: contentView.frame.size.height))
                line.backgroundColor = UIColor(hexString: "e3e3e3")
                line.center = (self.imageView?.center)!
                contentView.insertSubview(line, at: 0)
            }
        }
    }

    class MyTableViewSubCell: UITableViewCell {

        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 90, 0, 0))
            let line = UIView(frame: CGRect(x: -22.5, y: 0, width: 1, height: contentView.frame.size.height))
            line.backgroundColor = UIColor(hexString: "e3e3e3")
            
            contentView.insertSubview(line, at: 0)
        }
    }

}


extension ContactFilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case segment:
//            print(segments[indexPath.row])
            filterOptions.segment = segments[indexPath.row]
//            print(filterOptions.segment)
        case tag:
            filterOptions.tag = tags.filter{$0.name==list[indexPath.row - 1]}[0]
        case integration:
            filterOptions.integrationType = integrations[indexPath.row]
        case brand:
            filterOptions.brand = brands.filter{$0.name == list[indexPath.row - 1]}[0]
        case form:
            filterOptions.form = forms.filter{$0.name == list[indexPath.row - 1]}[0]
        case lead:
            filterOptions.lead = leadStatus[indexPath.row]
        case lifecycle:
            filterOptions.lifeCycle = lifeCycleStates[indexPath.row]
        default: break
        }
        
        tableView.reloadData()
        collapseSection(selectedSection)
        print(filterOptions)
    }
}

extension ContactFilterController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == selectedSection {
            return itemCount(section: section)
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = MyTableViewCell(style: .default, reuseIdentifier: "cell") as UITableViewCell
        cell.textLabel?.font = UIFont.fontWith(type: .comfortaa, size: 13)
        cell.textLabel?.textColor = UIColor(hexString: "#1f9fe2")
        switch indexPath.section {
        case segment:
            let segment = self.segments[indexPath.row]
            cell.textLabel?.text = segment.name
            cell.imageView?.image = UIImage(named: "ic_dot")
            cell.textLabel?.font = UIFont.fontWith(type: .comfortaaBold, size: 13)
            if !segment.subOf.isNullOrEmpty {
                cell = MyTableViewSubCell(style: .default, reuseIdentifier: "subCell") as UITableViewCell
                cell.textLabel?.font = UIFont.fontWith(type: .comfortaa, size: 13)
                cell.textLabel?.textColor = UIColor(hexString: "#1f9fe2")
                cell.textLabel?.text = segment.name
            }
        case tag:
            if indexPath.row == 0 {
                cell = InputCell(style: .default, reuseIdentifier: InputCell.ID)
                (cell as! InputCell).input.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
            }else {
                cell.textLabel?.text = list[indexPath.row - 1]
            }
        case integration:
            cell.textLabel?.text = integrations[indexPath.row]
        case brand:
            if indexPath.row == 0 {
                cell = InputCell(style: .default, reuseIdentifier: InputCell.ID)
                (cell as! InputCell).input.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
            }else {
                cell.textLabel?.text = list[indexPath.row - 1]
            }
        case form:
            if indexPath.row == 0 {
                cell = InputCell(style: .default, reuseIdentifier: InputCell.ID)
                (cell as! InputCell).input.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
            }else {
                cell.textLabel?.text = list[indexPath.row - 1]
            }
        case lead:
            cell.textLabel?.text = leadStatus[indexPath.row]
        case lifecycle:
            cell.textLabel?.text = lifeCycleStates[indexPath.row]
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()

        view.backgroundColor = .white
        let line = UIView(frame: CGRect(x: 12, y: 0, width: Constants.SCREEN_WIDTH - 24, height: 1))
        line.backgroundColor = UIColor(hexString: "#eaeaea")
        view.addSubview(line)

        let lbl = UILabel(frame: CGRect(x: 40, y: 0, width: 120, height: 42))
        lbl.text = sections[section]
        lbl.font = UIFont.fontWith(type: .comfortaaBold, size: 15)
        
        view.addSubview(lbl)
        view.tag = section

        let lblValue = UILabel(frame: CGRect(x: Constants.SCREEN_WIDTH - 205, y: 0, width: 180, height: 42))
        lblValue.text = sections[section]
        lblValue.font = UIFont.fontWith(type: .comfortaaBold, size: 12)
        lblValue.textColor = .gray
        lblValue.textAlignment = .right
        
        view.addSubview(lblValue)

        let iv = UIImageView(frame: CGRect(x: Constants.SCREEN_WIDTH - 30, y: 17, width: 20, height: 10))
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "ic_right_bracket")
        view.addSubview(iv)

        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(sectionSelected(_:)))
        view.addGestureRecognizer(tapGesture)
        lblValue.text = ""

        switch section {
        case segment:
            if let item = filterOptions.segment?.name {
                lblValue.text = item
            }
        case tag:
            if let item = filterOptions.tag?.name {
                lblValue.text = item
            }
        case integration:
            lblValue.text = filterOptions.integrationType
        case brand:
            if let item = filterOptions.brand?.name {
                lblValue.text = item
            }
        case form:
            if let item = filterOptions.form?.name {
                lblValue.text = item
            }
        case lead:
            lblValue.text = filterOptions.lead
        case lifecycle:
            lblValue.text = filterOptions.lifeCycle
        default:
            lblValue.text = ""
        }

        return view
    }

    func itemCount(section: Int) -> Int {
        switch section {
        case segment:
            return segments.count
        case tag:
            return list.count + 1
        case integration:
            return integrations.count
        case brand:
            return list.count + 1
        case form:
            return list.count + 1
        case lead:
            return leadStatus.count
        case lifecycle:
            return lifeCycleStates.count
        default:
            return 0
        }
    }

    @objc func sectionSelected(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {

            //            expandSection(section)

            if selectedSection >= 0 {
                let oldSection = selectedSection
                collapseSection(oldSection)
                if oldSection != section {
                    expandSection(section)
                }
            } else {
                expandSection(section)
            }
        }
    }

    func collapseSection(_ section: Int) {
        var indexes = [IndexPath]()
        let sectionSize = tableView.numberOfRows(inSection: section)
        for i in 0 ..< sectionSize {
            indexes.append(IndexPath(row: i, section: section))
        }

        tableView.beginUpdates()
        tableView.deleteRows(at: indexes, with: .fade)
        selectedSection = -1
        tableView.endUpdates()
        list = []
        self.view.endEditing(true)
    }

    func expandSection(_ section: Int) {
        var indexes = [IndexPath]()
        let sectionSize = itemCount(section: section)
        print("section size =", sectionSize)
        for i in 0 ..< sectionSize {
            indexes.append(IndexPath(row: i, section: section))
        }

        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: .fade)
        selectedSection = section
        tableView.endUpdates()
    }

    func refreshSection(_ section: Int) {
        var indexes = [IndexPath]()
        let sectionSize = itemCount(section: section)
        for i in 0 ..< sectionSize {
            indexes.append(IndexPath(row: i, section: section))
        }

        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: .fade)
        selectedSection = section
        tableView.endUpdates()
    }
    
    @objc func inputChanged(_ sender:UITextField) {
        
        guard let value = sender.text else {
            return
        }
        
        tableView.beginUpdates()
        
        if list.count > 0 {
            var oldIndexes = [IndexPath]()
            for i in 1 ... list.count {
                oldIndexes.append(IndexPath(row: i, section: selectedSection))
            }
            tableView.deleteRows(at: oldIndexes, with: .fade)
            list = []
        }
        
        if value.count > 0 {
            
            var tmp = [String]()
            
            switch selectedSection {
            case tag:
               
                tmp = tags.filter{$0.name!.localizedCaseInsensitiveContains(value)}.map{$0.name!}
            case brand:
                tmp = brands.filter{$0.name!.localizedCaseInsensitiveContains(value)}.map{$0.name!}
            case form:
                tmp = forms.filter{$0.name.localizedCaseInsensitiveContains(value)}.map{$0.name}
            default:
                tmp = []
            }
            
            if tmp.count > 0 {
                var newIndexes = [IndexPath]()
                for i in 1 ... tmp.count {
                    newIndexes.append(IndexPath(row: i, section: selectedSection))
                }
                tableView.insertRows(at: newIndexes, with: .fade)
                list = tmp
            }
        }
        tableView.endUpdates()
    }
}
