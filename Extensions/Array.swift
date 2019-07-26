//
//  Array.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/16/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation

extension Array {
    func contain<T>(obj: T) -> Bool where T: Equatable {
        return self.filter({ $0 as? T == obj }).count > 0
    }
}
