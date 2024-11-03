//
//  NSAttributedString+Extension.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 02/11/24.
//

import UIKit

extension NSAttributedString {
    
    /// Creates an attributed string with the specified attributes.
    static func custom(color: UIColor? = nil, fontSize: CGFloat? = nil, text: String) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let color {
            attributes[.foregroundColor] = color
        }
        if let fontSize {
            attributes[.font] = UIFont.systemFont(ofSize: fontSize)
        }
        return NSAttributedString(string: text, attributes: attributes)
    }

    /// Combines multiple attributed strings.
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: left)
        mutableAttributedString.append(right)
        return mutableAttributedString
    }
}

extension String {
    static func rupee<T: Numeric>(_ numeric: T) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = GlobalConstants.rupeeSign
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        let number = numeric as? Double ?? Double("\(numeric)") ?? 0.0
        return GlobalConstants.rupeeSign + (formatter.string(from: NSNumber(value: number)) ?? "")
    }
}
