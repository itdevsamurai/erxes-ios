//
//  Box.swift
//  erxes-ios
//
//  Created by Purev-Yondon on 10/8/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener:Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
