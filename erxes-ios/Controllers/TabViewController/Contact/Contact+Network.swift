//
//  Contact+Network.swift
//  erxes-ios
//
//  Created by alternate on 11/15/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import UIKit
import Apollo

extension ContactController {
    
    func getCompanies(limit: Int = 20) {
        
        if loading {
            return
        }
        loading = true
        
        let query = CompaniesQuery()
        
        if options != nil {
            query.segment = options?.segment?.id
            query.tag = options?.tag?.id
            query.brand = options?.brand?.id
            query.leadStatus = options?.lead
            query.lifecycleState = options?.lifeCycle
        }
        query.searchValue = searchField.text
        query.perPage = limit
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            
            self?.loading = false
            
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
                if let allCompanies = result?.data?.companies {
                    self?.companies = allCompanies.map { ($0?.fragments.companyList)! }
                    if allCompanies.count == self?.companiesLimit {
                        self?.hasNextPage = true
                    } else {
                        self?.hasNextPage = false
                    }
                }
            }
        }
    }
    
    func getCustomers(limit: Int = 20) {
        
        if loading {
            return
        }
        loading = true
        
        let query = CustomersQuery()
        if options != nil {
            query.segment = options?.segment?.id
            query.tag = options?.tag?.id
            query.brand = options?.brand?.id
            query.form = options?.form?.id
            query.leadStatus = options?.lead
            query.lifecycleState = options?.lifeCycle
            query.integration = options?.integrationType
        }
        query.searchValue = searchField.text
        query.perPage = limit
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            
            self?.loading = false
            
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                //                self?.hideLoader()
                
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                //                self?.hideLoader()
                
            }
            
            if result?.data != nil {
                if let allCustomers = result?.data?.customers {
                    self?.customers = allCustomers.map { ($0!.fragments.customerList) }
                    if allCustomers.count == self?.customersLimit {
                        self?.hasNextPage = true
                    } else {
                        self?.hasNextPage = false
                    }
                }
            }
        }
    }
}
