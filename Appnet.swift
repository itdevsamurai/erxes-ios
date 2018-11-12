//
//  Appnet.swift
//  erxes-ios
//
//  Created by alternate on 8/21/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo

var appnet = Appnet()

class Appnet: NSObject {
    
    var token:String?
    
    func refreshClient() {
        tokenChanged = false
       
        client = Appnet.newClient(token: token)
    }
    
    var isAnimating:Bool = false
    
    var client: ApolloClient?
    
    
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let url = URL(string: Constants.API_ENDPOINT)!
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    
    var tokenChanged = true
    
    public static func temporarySQLiteFileURL() throws -> URL{
        let applicationSupportPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!
        let applicationSupportURL = URL(fileURLWithPath: applicationSupportPath)
        
        let temporaryDirectoryURL = try FileManager.default.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: applicationSupportURL,
            create: true)
        return temporaryDirectoryURL.appendingPathComponent("db.sqlite3")
    }
    
    class func newClient(token:String?) -> ApolloClient{
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["x-token": token as Any]
        let url = URL(string: Constants.API_ENDPOINT)
        let transport = HTTPNetworkTransport(url: url!, configuration: configuration)
        do {
            let fileURL = try temporarySQLiteFileURL()
            print(fileURL)
            let cache = try SQLiteNormalizedCache(fileURL: fileURL)
            let store = ApolloStore(cache: cache)
            let client = ApolloClient(networkTransport: transport, store:store)
            return client
            //        store.cacheKeyForObject = { $0["_id"] }
        } catch {
            let client = ApolloClient(networkTransport: transport)
            return client
        }
    }
    
    func fetch<Query:GraphQLQuery>(query: Query, cachePolicy: CachePolicy = .returnCacheDataElseFetch, queue: DispatchQueue = DispatchQueue.main, callback: @escaping OperationResultHandler<Query>) {
        
        if tokenChanged {
            refreshClient()
        }
        let topController = UIApplication.topViewController()
        if !isAnimating {
            topController?.showLoader()
            isAnimating = true
        }
        
        var cache = cachePolicy
        if !isOnline {
            cache = .returnCacheDataDontFetch
        } else {
            cache = .fetchIgnoringCacheData
        }
        
        let q = query
        client?.fetch(query: query, cachePolicy: cache, queue:queue) { result, error in
            
            guard let err = result?.errors?.first, err.description == "Login required" else {
                callback(result, error)
                topController?.hideLoader()
                self.isAnimating = false
                return
            }
            
            let loginMutation = LoginMutation(email:ErxesUser.storedEmail() ,password:ErxesUser.storedPassword())
            self.apollo.perform(mutation: loginMutation) { [weak self] result, error in
                if error != nil {
                    topController?.hideLoader()
                    self?.isAnimating = false
                    return
                }
                
                if let err = result?.errors {
                    let alert = FailureAlert(message:err[0].localizedDescription)
                    alert.show(animated: true)
                    topController?.hideLoader()
                    self?.isAnimating = false
                    return
                }
                
                guard let resultData = result?.data else {
                    topController?.hideLoader()
                    self?.isAnimating = false
                    return
                }
                
                self?.token = (result?.data?.login)!
                self?.tokenChanged = true
                
                topController?.hideLoader()
                self?.isAnimating = false
                let cl = Appnet.newClient(token: resultData.login)
                cl.fetch(query: q, cachePolicy:cache, queue:queue) { result, error in
                    print("fetched again")
                    callback(result, error)
                }
            }
        }
    }
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue = DispatchQueue.main, handler: OperationResultHandler<Mutation>? = nil) {
        let topController = UIApplication.topViewController()
        topController?.showLoader()
        let mut = mutation
        
        client?.perform(mutation: mutation, queue:queue) { [weak self] result, error in
            guard let handler = handler else {
                return
            }
            
            guard let err = result?.errors?.first, err.description == "Login required" else {
                handler(result, error)
                topController?.hideLoader()
                self?.isAnimating = false
                return
            }
            
            let loginMutation = LoginMutation(email:ErxesUser.storedEmail() ,password:ErxesUser.storedPassword())
            self?.apollo.perform(mutation: loginMutation) { [weak self] result, error in
                if error != nil {
                    topController?.hideLoader()
                    self?.isAnimating = false
                    return
                }
                if let err = result?.errors {
                    let alert = FailureAlert(message:err[0].localizedDescription)
                    alert.show(animated: true)
                    topController?.hideLoader()
                    self?.isAnimating = false
                }
                if result?.data != nil {
                    self?.token = (result?.data?.login)!
                    self?.tokenChanged = true
                    
                    topController?.hideLoader()
                    self?.isAnimating = false
                    let cl = Appnet.newClient(token: result?.data?.login)
                    cl.perform(mutation:mut, queue:queue) { result, error in
                        handler(result, error)
                    }
                }
            }
        }
    }
}
