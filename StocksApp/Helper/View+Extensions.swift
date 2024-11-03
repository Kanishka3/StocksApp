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

class LabelStackView: UIStackView {
    let leftLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    init() {
        super.init(frame:. zero)
        addArrangedSubviews(leftLabel, UIView(), rightLabel)
    }
    
    func setData(leftText: String, rightText: String) {
        leftLabel.text = leftText
        rightLabel.text = rightText
    }
    
    func setData(leftText: NSAttributedString, rightText: NSAttributedString) {
        leftLabel.attributedText = leftText
        rightLabel.attributedText = rightText
    }
    
    func setRightLabelColor(color: UIColor) {
        rightLabel.textColor = color
    }
    
    func prepareForReuse() {
        [leftLabel, rightLabel].forEach {
            $0.text = nil
            $0.attributedText = nil
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let estimatedHeight: CGFloat = 20
}
