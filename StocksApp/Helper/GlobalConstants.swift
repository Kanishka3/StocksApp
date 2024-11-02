//
//  GlobalConstants.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 01/11/24.
//

import Foundation

enum GlobalConstants {
    static let dataUrl = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
    static let padding = CGFloat(12)
    static let interitemSpacing = CGFloat(24)
    
    static let ltpPrefix = "LTP: "
    static let netQuantityPrefix = "NET QUANTITY: "
    static let pnlPrefix = "PNL: "
    static let rupeeSign = "₹"
    
    static let smallFont = CGFloat(10)
    static let regularFont = CGFloat(16)

    static let pnlString = "Profit & Loss*"
    static let currentValue = "Current value*"
    static let totalInvestment = "Total Investment*"
    static let totalPnl = "Today's Profit & Loss"
    
    static let chevronUp = "chevron.up"
    static let chevronDown = "chevron.down"
    
    static let cornerRadius = CGFloat(16)
}
