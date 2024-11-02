//
//  UIView+Extensions.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 01/11/24.
//

import UIKit

public extension UIView {
    
    // Helper function which adds multiple subviews to a view
    func addSubviews(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false 
            self.addSubview($0)
        })
    }
}
    
extension UIStackView {
    // Helper function which adds multiple subviews to a view
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}

extension CACornerMask {
    static var top: CACornerMask {
        return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
