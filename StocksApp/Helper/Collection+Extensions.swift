//
//  Collection+Extensions.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 02/11/24.
//

import Foundation

public extension MutableCollection {
    subscript (safe index: Index) -> Element? {
        get {
            guard index >= startIndex, index < endIndex else {
                return nil
            }
            
            return self[index]
        }
        
        mutating set(newValue) {
            if let newValue = newValue, index >= startIndex, index < endIndex {
                self[index] = newValue
            }
        }
    }
}
