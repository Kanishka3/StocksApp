//
//  Observable.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 01/11/24.
//

import Foundation

public class Observable<T> {
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    public init(value: T) {
        self.value = value
    }
    
    public func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
