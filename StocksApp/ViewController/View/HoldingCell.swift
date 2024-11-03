//
//  HoldingCell.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 02/11/24.
//

import UIKit



class HoldingCell: UITableViewCell {
    let topStackView = LabelStackView()
    let bottomStackView = LabelStackView()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = GlobalConstants.interitemSpacing
        stackView.distribution = .equalCentering
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        addSubviews(contentStack)
        contentStack.addArrangedSubviews(topStackView, bottomStackView)

        contentStack.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: GlobalConstants.padding).isActive = true
        contentStack.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -GlobalConstants.padding).isActive = true
        contentStack.topAnchor.constraint(equalTo: topAnchor,
                                          constant: GlobalConstants.padding).isActive = true
        contentStack.bottomAnchor.constraint(equalTo: bottomAnchor,
                                          constant: -GlobalConstants.padding).isActive = true
    }
    
    func setData(from object: Holding, calculatedPnl: Double) {
    
        topStackView.setData(leftText: titleText(object),
                             rightText:  ltpText(object))
        
        bottomStackView.setData(leftText: netQuantity(object), rightText: pnlString(pnl: calculatedPnl))
    }
    
    private func titleText(_ object: Holding) -> NSAttributedString {
        .custom(text: object.symbol)
    }
    
    private func ltpText(_ object: Holding) -> NSAttributedString {
        let prefixLabel = NSAttributedString.custom(color: .lightGray,
                                                    fontSize: GlobalConstants.smallFont,
                                                    text: GlobalConstants.ltpPrefix)
        let ltpLabel = NSAttributedString.custom(color: .darkGray,
                                                 fontSize: GlobalConstants.regularFont,
                                                 text: .rupee(object.ltp))
        return prefixLabel + ltpLabel
    }
    
    private func netQuantity(_ object: Holding) -> NSAttributedString {
        let prefixLabel = NSAttributedString.custom(color: .lightGray,
                                                    fontSize: GlobalConstants.smallFont,
                                                    text: GlobalConstants.netQuantityPrefix)
        let netQuantity = NSAttributedString.custom(color: .darkGray,
                                                     fontSize: GlobalConstants.regularFont,
                                                     text: .rupee(object.quantity))
        return prefixLabel + netQuantity
    }
    
    private func pnlString(pnl: Double) -> NSAttributedString {
        let prefixLabel = NSAttributedString.custom(color: .lightGray,
                                                           fontSize: GlobalConstants.smallFont,
                                                           text: GlobalConstants.pnlPrefix)
        let pnlString = NSAttributedString.custom(color: pnl > 0 ? .green : .red,
                                                          fontSize: GlobalConstants.regularFont,
                                                          text: .rupee(pnl))
        return prefixLabel + pnlString
    }
    
    override func prepareForReuse() {
        topStackView.prepareForReuse()
        bottomStackView.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
