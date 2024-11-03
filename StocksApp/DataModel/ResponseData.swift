//
//  ResponseModel.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 01/11/24.
//


public typealias Holding = ResponseData.Holding

public struct ResponseData: Decodable {
    let data: CollectionObject
    
    struct CollectionObject: Decodable {
        let userHolding: [Holding]
    }
    
    public struct Holding: Decodable {
        
        public init(symbol: String, quantity: Int, ltp: Double, avgPrice: Double, close: Double) {
            self.symbol = symbol
            self.quantity = quantity
            self.ltp = ltp
            self.avgPrice = avgPrice
            self.close = close
        }
        
        public let symbol: String
        public let quantity: Int
        public let ltp, avgPrice, close: Double
    }
}
