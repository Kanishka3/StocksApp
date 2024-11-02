//
//  ResponseModel.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 01/11/24.
//


typealias Holding = ResponseData.Holding

struct ResponseData: Decodable {
    let data: CollectionObject
    
    struct CollectionObject: Decodable {
        let userHolding: [Holding]
    }
    
    struct Holding: Decodable {
        let symbol: String
        let quantity: Int
        let ltp, avgPrice, close: Double
    }
}
