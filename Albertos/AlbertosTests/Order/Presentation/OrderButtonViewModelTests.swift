//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class OrderButtonViewModelTests: XCTestCase {

    func test_whenOrderIsEmpty_doesNotShowTotal() {
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.text, "Your Order")
    }

    func test_whenOrderIsNotEmpty_showsTotal() {
        let (sut, order) = makeSUT()
        
        order.addToOrder(item: .fixture(price: 1.0))
        XCTAssertEqual(sut.text, "Your Order $1.00")
        
        order.addToOrder(item: .fixture(price: 2.3))
        XCTAssertEqual(sut.text, "Your Order $3.30")
        
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (OrderButton.ViewModel, OrderController) {
        let orderController = OrderController(orderStoring: OrderStoringFake())
        let sut = OrderButton.ViewModel(orderController: orderController)
     
        trackForMemoryLeaks(orderController, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, orderController)
    }
}
