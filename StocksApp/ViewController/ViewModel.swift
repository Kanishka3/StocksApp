//
//  ViewModel.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 01/11/24.
//

import Foundation
import UIKit

open class ViewModel {
    
    public enum State {
        case none, loading, loaded
    }
    
    public private(set) var state = Observable<State>(value: .none)
    
    public private(set) var collection = Observable<[Holding]>(value: [])
    
    func fetchData() {
        let url = URL(string: GlobalConstants.dataUrl)
        guard let url else { return }
        state.value = .loading
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let data, let self else {
                self?.state.value = .loaded // can do error state
                return }
            let response = try? JSONDecoder().decode(ResponseData.self, from: data)
            self.collection.value = response?.data.userHolding ?? []
            self.state.value = .loaded
        }.resume()
    }
    
    public init() {}
    
    //Current value = sum of (Last traded price * quantity of holding ) of all the holdings
    public var currentValue: Double {
        collection.value.reduce(0) { (accumulator, holding) in
            accumulator + (holding.ltp * Double(holding.quantity))
        }
    }
    
    //Total investment = sum of (Average Price * quantity of holding ) of all the holdings
    public var totalInvestment: Double {
        collection.value.reduce(0) { (accumulator, holding) in
            accumulator + (holding.avgPrice * Double(holding.quantity))
        }
    }
    
    public func pnl(_ holding: Holding) -> Double {
        (holding.ltp - holding.avgPrice) * Double(holding.quantity)
    }
    
    // Total PNL = Current value - Total Investment
    var totalPNL: (value: Double, isProfit: Bool) {
        let value = currentValue - totalInvestment
        return (value: value, isProfit: value > 0)
    }
    
    //Today’s PNL = sum of ((Close - LTP ) * quantity) of all the holdings
     public var todaysPnl: (value: Double, isProfit: Bool) {
       let value = collection.value.reduce(0) { totalPNL, holding in
            let pnl = (holding.close - holding.ltp) * Double(holding.quantity)
           return totalPNL + pnl
        }
        return (value: value, isProfit: value > 0)
    }
    
    func getStickyViewModel() -> BottomStickyView.StickyViewModel {
        let collapsedViewModel: [BottomStickyView.CollapsedViewModel] = [
            .init(leftText: GlobalConstants.currentValue, rightText: .rupee(currentValue)),
            .init(leftText: GlobalConstants.totalInvestment, rightText: .rupee(totalInvestment)),
            .init(leftText: GlobalConstants.totalPnl,
                  rightText: .rupee(todaysPnl.value),
                  rightTextColor: todaysPnl.isProfit ? .green : .red)
        ]
        let viewModel = BottomStickyView.StickyViewModel(collapsedViewModel: collapsedViewModel,
                                                         title: GlobalConstants.pnlString,
                                                         rightText: .rupee(totalPNL.value),
                                                         rightTextColor: totalPNL.isProfit ? .green : .red)
        return viewModel
    }
}
