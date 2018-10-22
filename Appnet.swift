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
    
    public static func temporarySQLiteFileURL() -> URL {
        let applicationSupportPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!
        let applicationSupportURL = URL(fileURLWithPath: applicationSupportPath)
        let temporaryDirectoryURL = try! FileManager.default.url(
            for: .itemReplacementDirectory,
            in: .userDomainMask,
            appropriateFor: applicationSupportURL,
            create: true)
        return temporaryDirectoryURL.appendingPathComponent("db.sqlite3")
    }
    
    class func newClient(token:String?) -> ApolloClient{
        
        let fileURL = temporarySQLiteFileURL()
        let cache = try! SQLiteNormalizedCache(fileURL: fileURL)
        let store = ApolloStore(cache: cache)
        store.cacheKeyForObject = { $0["id"] }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["x-token": token as Any]
        let url = URL(string: Constants.API_ENDPOINT)!
        let transport = HTTPNetworkTransport(url: url, configuration: configuration)
        let client = ApolloClient(networkTransport: transport, store:store)
    
        return client
    }
    
    func fetch<Query:GraphQLQuery>(query: Query, cachePolicy: CachePolicy = .returnCacheDataElseFetch, queue: DispatchQueue = DispatchQueue.main, handler: @escaping OperationResultHandler<Query>) {
        
        if tokenChanged {
            refreshClient()
        }
        let topController = UIApplication.topViewController()
        if !isAnimating {
            topController?.showLoader()
            isAnimating = true
        }
        let q = query
        client?.fetch(query: query, cachePolicy: cachePolicy, queue:queue) { result, error in
            
            if let errors = result?.errors, errors.count > 0 {
                let err = errors.first
                if err?.description == "Login required" {
                    print("login required")
                    let loginMutation = LoginMutation(email:ErxesUser.storedEmail() ,password:ErxesUser.storedPassword())
                    self.apollo.perform(mutation: loginMutation) { [weak self] result, error in
                        if let error = error {
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
                            self?.token = (result?.data?.login.token)!
                            self?.tokenChanged = true
                            
                            topController?.hideLoader()
                            self?.isAnimating = false
                            let cl = Appnet.newClient(token: result?.data?.login.token)
                            cl.fetch(query: q, cachePolicy:cachePolicy, queue:queue) { result, error in
                                print("fetched again")
                                handler(result, error)
                            }
                        } else {
                            topController?.hideLoader()
                            self?.isAnimating = false
                        }
                    }
                } else {
                    handler(result, error)
                    topController?.hideLoader()
                    self.isAnimating = false
                }
            } else {
                handler(result, error)
                topController?.hideLoader()
                self.isAnimating = false
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
            
            if let errors = result?.errors, errors.count > 0 {
                let err = errors.first
                if err?.description == "Login required" {
                    let loginMutation = LoginMutation(email:ErxesUser.storedEmail() ,password:ErxesUser.storedPassword())
                    self?.apollo.perform(mutation: loginMutation) { [weak self] result, error in
                        if let error = error {
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
                            self?.token = (result?.data?.login.token)!
                            self?.tokenChanged = true
                            
                             topController?.hideLoader()
                            self?.isAnimating = false
                            let cl = Appnet.newClient(token: result?.data?.login.token)
                            cl.perform(mutation:mut, queue:queue) { result, error in
                                handler(result, error)
                            }
                        }
                    }
                } else {
                    handler(result, error)
                     topController?.hideLoader()
                    self?.isAnimating = false
                }
            } else {
                handler(result, error)
                 topController?.hideLoader()
                self?.isAnimating = false
            }
        }
    }
    

    
}
