//
//  Optional.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation

protocol StringType {
    var isEmpty: Bool { get }
}

extension String: StringType {
    
}

extension Optional where Wrapped: StringType {
    var isNullOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
