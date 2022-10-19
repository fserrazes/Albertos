//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore

final class OrderControllerTests: XCTestCase {
    
    func test_initsWithEmptyOrder() {
        let sut = makeSUT()

        XCTAssertTrue(sut.order.items.isEmpty)
    }
    
    func test_whenItemNotInOrder_returnsFalse() {
        let sut = makeSUT()
        sut.addToOrder(item: .fixture(name: "a name"))

        XCTAssertFalse(sut.isItemInOrder(.fixture(name: "another name")))
    }
    
    func test_whenItemInOrder_returnsTrue() {
        let sut = makeSUT()
        sut.addToOrder(item: .fixture(name: "a name"))

        XCTAssertTrue(sut.isItemInOrder(.fixture(name: "a name")))
    }
    
    func test_addingItem_updatesOrder() {
        let sut = makeSUT()

        let item = MenuItem.fixture()
        sut.addToOrder(item: item)

        XCTAssertEqual(sut.order.items.count, 1)
        XCTAssertEqual(sut.order.items.first, item)
    }
    
    func test_removeItem_updatesOrder() {
        let item = MenuItem.fixture(name: "a name")
        let otherItem = MenuItem.fixture(name: "another name")
        
        let sut = makeSUT()
        sut.addToOrder(item: item)
        sut.addToOrder(item: otherItem)

        sut.removeFromOrder(item: item)

        XCTAssertEqual(sut.order.items.count, 1)
        XCTAssertEqual(sut.order.items.first, otherItem)
    }
    
    // MARK: - Helpers
    private func makeSUT() -> OrderController {
        let controller = OrderController(orderStoring: OrderStoringFake())
        return controller
    }
    
    private class OrderStoringFake: OrderStoring {
        private var order: Order = Order(items: [])

        public func getOrder() -> Order {
            return order
        }

        public func updateOrder(_ order: Order) {
            self.order = order
        }
    }
}
