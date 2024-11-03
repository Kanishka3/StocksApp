//
//  StocksAppTests.swift
//  StocksAppTests
//
//  Created by Kanishka Chaudhry on 03/11/24.
//

import XCTest
import StocksApp

final class StocksAppTests: XCTestCase {

    let viewModel = ViewModel()
    
    override func setUpWithError() throws {
        viewModel.collection.value = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTotalInvestmentCalculation() {
        let holding = Holding(symbol: "AAPL", quantity: 100, ltp: 118.25, avgPrice: 110.0, close: 105)
       viewModel.collection.value = [holding]
        let totalInvestment = viewModel.totalInvestment
          // Then
        XCTAssertEqual(totalInvestment, 11000.0, "Total investment should be calculated correctly.")
      }
    
    
    func testCurrentValueCalculation() {
        let holding = Holding(symbol: "AAPL", quantity: 100, ltp: 118.25, avgPrice: 110.0, close: 105)
        viewModel.collection.value = [holding]
        let currentValue = viewModel.currentValue
        XCTAssertEqual(currentValue, 11825, "Current value should be calculated correctly.")
    }
    
    func testTodaysPnlCalculation() {
        let holding = Holding(symbol: "AAPL", quantity: 100, ltp: 118.25, avgPrice: 110.0, close: 105.0)
        viewModel.collection.value = [holding]
        let todaysPnlValue = viewModel.todaysPnl.value
        XCTAssertEqual(todaysPnlValue, -1325.0, "Today's PNL should be calculated correctly.")
    }

    
    func testPNLCalculation() {
        let holding = Holding(symbol: "AAPL", quantity: 100, ltp: 118.25, avgPrice: 110.0, close: 105)
        viewModel.collection.value = [holding]
        let pnl = viewModel.pnl(holding)
        XCTAssertEqual(pnl, 825.0, "PNL should be calculated correctly.")
    }
}
