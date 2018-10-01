//
//  BrandFilterController.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 5/15/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo
import SnapKit


protocol BrandDelegate: class  {
    func getSelectedData(options:FilterOptions)
}

class BrandFilterController: UIViewController {

    
    
    weak var delegate: BrandDelegate?
    
    var filterOptions = FilterOptions()
    
 
    
    var brands = [BrandDetail](){
        didSet{
            tableView.reloadData()
        }
    }
    
    
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
        getBrands()

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

}

extension BrandFilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brand = brands[indexPath.row]
        filterOptions.brand = brand
        self.dismiss(animated: true) {
            self.delegate?.getSelectedData(options: self.filterOptions)
        }
    }
}

extension BrandFilterController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell
        let brand = brands[indexPath.row]
        cell?.desc.text = brand.name
//        cell?.value.text = "(" + String(describing: brand.!) + ")"
//        cell?.value.text = "0"
        cell?.arrow.isHidden = true
        return cell!
    }
}
