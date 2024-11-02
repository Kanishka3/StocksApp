//
//  Numerics+Extension.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 02/11/24.
//

import Foundation

extension Double {
    /// Rounds the double to the specified number of decimal places.
    func rounded(toDecimals decimals: Int) -> Double {
        let divisor = pow(10.0, Double(decimals))
        return (self * divisor).rounded() / divisor
    }
    
    var str: String {
        String(self)
    }
}
