//
//  TagFilterController.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 5/21/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import SnapKit

protocol TagDelegate: class  {
    func setTag(options:FilterOptions)
}
class TagFilterController: UIViewController {

    weak var delegate: TagDelegate?
    
    var filterOptions = FilterOptions()
    
    var tags = [TagDetail]() {
        didSet{
            tableView.reloadData()
        }
    }
    
 
   
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TagCell.self, forCellReuseIdentifier: "TagCell")
        tableView.rowHeight = 40
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.ERXES_COLOR
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        self.view.backgroundColor = .clear
        
        getTags()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTags(){
        
        
        let query = TagsQuery(type: "conversation")
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataAndFetch) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                print( err[0].localizedDescription)
                alert.show(animated: true)
                
                return
            }
            
            if result?.data != nil {
                if let allTags  = result?.data?.tags {
                    
                    self?.tags = allTags.map { ($0?.fragments.tagDetail)! }
                    
                    
                }
                
            }
        }
    }


}

extension TagFilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        filterOptions.tag = tag
        self.dismiss(animated: true) {
            self.delegate?.setTag(options: self.filterOptions)
        }
    }
}

extension TagFilterController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as? TagCell
        let tag = tags[indexPath.row]
        
        cell?.desc.text = tag.name!
//        cell?.value.text = "0"
        cell?.tagView.image = UIImage.erxes(with: .tag, textColor: .black, size: CGSize(width: 22, height: 22 ))
        cell?.tagView.image = cell?.tagView.image!.withRenderingMode(.alwaysTemplate)
        cell?.tagView.tintColor = UIColor(hexString: tag.colorCode!)
        return cell!
    }
}
