//
//  ChannelFilterController.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 5/15/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo


protocol ChannelDelegate: class  {
    func getSelectedChannelData(options:FilterOptions)
}

class ChannelFilterController: UIViewController {

    var channelWatcher: GraphQLQueryWatcher<ChannelsQuery>?
    
    var channels = [ChannelDetail](){
        didSet {
            tableView.reloadData()
        }
    }
    
  
    
    weak var channelDelegate: ChannelDelegate?
    
    var filterOptions = FilterOptions()

    
    
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
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

        getChannels()
    }
    
    deinit {
        channelWatcher?.cancel()
    }
    
    func getChannels(){
        
            let query = ChannelsQuery()
        
//
        
             appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataElseFetch) { [weak self] result, error in
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
                    if let allchannels = result?.data?.channels {
                        self?.channels = allchannels.map { ($0?.fragments.channelDetail)! }
                        
                    }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension ChannelFilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = channels[indexPath.row]
        filterOptions.channel = channel
        self.dismiss(animated: true) {
            self.channelDelegate?.getSelectedChannelData(options:self.filterOptions)
        }
    }
}

extension ChannelFilterController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell
        let channel = channels[indexPath.row]
        cell?.desc.text = channel.name
//        cell?.value.text = String(describing: channel.conversationCount!)
        cell?.arrow.isHidden = true
        return cell!
    }
}
