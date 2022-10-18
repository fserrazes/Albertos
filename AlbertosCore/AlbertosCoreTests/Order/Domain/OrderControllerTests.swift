//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore

final class OrderControllerTests: XCTestCase {
    
    func test_initsWithEmptyOrder() {
        let controller = OrderController()

        XCTAssertTrue(controller.order.items.isEmpty)
    }
    
    func test_whenItemNotInOrder_returnsFalse() {
        let controller = OrderController()
        controller.addToOrder(item: .fixture(name: "a name"))

        XCTAssertFalse(controller.isItemInOrder(.fixture(name: "another name")))
    }
    
    func test_whenItemInOrder_returnsTrue() {
        let controller = OrderController()
        controller.addToOrder(item: .fixture(name: "a name"))

        XCTAssertTrue(controller.isItemInOrder(.fixture(name: "a name")))
    }
    
    func test_addingItem_updatesOrder() {
        let controller = OrderController()

        let item = MenuItem.fixture()
        controller.addToOrder(item: item)

        XCTAssertEqual(controller.order.items.count, 1)
        XCTAssertEqual(controller.order.items.first, item)
    }
}
