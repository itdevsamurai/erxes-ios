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
    
    var client: ApolloClient?
    
    var tokenChanged = true
    
    class func newClient(token:String?) -> ApolloClient{
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["x-token": token as Any]
        let url = URL(string: Constants.API_ENDPOINT)!
        let client = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        return client
    }
    
    func fetch<Query:GraphQLQuery>(query: Query, cachePolicy: CachePolicy = .returnCacheDataElseFetch, queue: DispatchQueue = DispatchQueue.main, handler: @escaping OperationResultHandler<Query>) {
        
        if tokenChanged {
            refreshClient()
        }
        
        let q = query
        client?.fetch(query: query, cachePolicy: cachePolicy, queue:queue) { result, error in
            
            if let errors = result?.errors, errors.count > 0 {
                let err = errors.first
                if err?.description == "Login required" {
                    print("login required")
                    let loginMutation = LoginMutation(email:ErxesUser.storedEmail() ,password:ErxesUser.storedPassword())
                    apollo.perform(mutation: loginMutation) { [weak self] result, error in
                        if let error = error {
                            return
                        }
                        if let err = result?.errors {
                            let alert = FailureAlert(message:err[0].localizedDescription)
                            alert.show(animated: true)
                        }
                        if result?.data != nil {
                            self?.token = (result?.data?.login.token)!
                            self?.tokenChanged = true
                            
                            
                            let cl = Appnet.newClient(token: result?.data?.login.token)
                            cl.fetch(query: q, cachePolicy:cachePolicy, queue:queue) { result, error in
                                print("fetched again")
                                handler(result, error)
                            }
                        }
                    }
                } else {
                    handler(result, error)
                }
            } else {
                handler(result, error)
            }
        }
    }
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation, queue: DispatchQueue = DispatchQueue.main, handler: OperationResultHandler<Mutation>? = nil) {
        
        let mut = mutation
        
        client?.perform(mutation: mutation, queue:queue) { [weak self] result, error in
            guard let handler = handler else {
                return
            }
            
            if let errors = result?.errors, errors.count > 0 {
                let err = errors.first
                if err?.description == "Login required" {
                    let loginMutation = LoginMutation(email:ErxesUser.storedEmail() ,password:ErxesUser.storedPassword())
                    apollo.perform(mutation: loginMutation) { [weak self] result, error in
                        if let error = error {
                            return
                        }
                        if let err = result?.errors {
                            let alert = FailureAlert(message:err[0].localizedDescription)
                            alert.show(animated: true)
                        }
                        if result?.data != nil {
                            self?.token = (result?.data?.login.token)!
                            self?.tokenChanged = true
                            
                            
                            let cl = Appnet.newClient(token: result?.data?.login.token)
                            cl.perform(mutation:mut, queue:queue) { result, error in
                                handler(result, error)
                            }
                        }
                    }
                } else {
                    handler(result, error)
                }
            } else {
                handler(result, error)
            }
        }
    }
    
}
