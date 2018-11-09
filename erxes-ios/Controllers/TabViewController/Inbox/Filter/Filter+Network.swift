//
//  Filter+Network.swift
//  erxes-ios
//
//  Created by alternate on 9/27/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import Foundation
import Apollo

extension FilterController {
    
    func getChannels() {
        let query = ChannelsQuery()
        
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
    
    func getBrands() {
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
    
    func getTags() {
        let query = TagsQuery(type: "conversation")
        appnet.fetch(query: query, cachePolicy: CachePolicy.returnCacheDataElseFetch) { [weak self] result, error in
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
