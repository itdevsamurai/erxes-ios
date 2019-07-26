//
//  CustomScalar.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation
import UIKit
import Apollo

public typealias JSON = [String: Any]
public typealias SDate = Int64

extension Int64: JSONDecodable, JSONEncodable {
    public init(jsonValue value: JSONValue) throws {
        
        let string = String(describing: value)
        guard let number = Int64(string) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Int64.self)
        }
        
        self = number
    }
    
    public var jsonValue: JSONValue {
        return String(self)
    }
}

extension Dictionary: JSONDecodable {
    public init(jsonValue value: JSONValue) throws {
        
        if let array = value as? NSArray {
            self.init()
            if var dict = self as? [String: JSONDecodable & JSONEncodable] {
                dict["data"] = array as! [[String: Any]]
                self = dict as! Dictionary<Key, Value>
                return
            }
        }
        
        guard let dictionary = value as? Dictionary else {
            
            throw JSONDecodingError.couldNotConvert(value: value, to: Dictionary.self)
        }
        self = dictionary
    }
}

extension Array: JSONDecodable {
    public init(jsonValue value: JSONValue) throws {
        guard let array = forceBridgeFromObjectiveC(value) as? Array else {
            
            throw JSONDecodingError.couldNotConvert(value: value, to: Array.self)
        }
        self = array
    }
}


private func forceBridgeFromObjectiveC(_ value: Any) -> Any {
    
    if value == nil {
        return value
    }
    
    switch value {
        
    case is NSString:
        return value as! String
        
    case is Bool:
        return value as! Bool
    case is Int:
        return value as! Int
    case is Int64:
        return value as! Int64
    case is Double:
        return value as! Double
    case is NSDictionary:
        return Dictionary(uniqueKeysWithValues: (value as! NSDictionary).map { ($0.key as! AnyHashable, forceBridgeFromObjectiveC($0.value)) })
    case is NSArray:
        return (value as? NSArray).map { forceBridgeFromObjectiveC($0) }
    default:
        return value
    }
}
