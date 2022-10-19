//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore

class OrderTests: XCTestCase {
    
    func test_totalSums_pricesOfEachItem() {
        let order = Order(
            items: [.fixture(price: 1.0), .fixture(price: 2.0), .fixture(price: 3.5)]
        )

        XCTAssertEqual(order.total, 6.5)
    }
    
    func test_HippoPaymentsPayload_HasOrderItemsNames() throws {
        let order = Order(
            items: [.fixture(name: "a name"), .fixture(name: "other name")]
        )

        let payload = order.hippoPaymentsPayload

        let payloadItems = try XCTUnwrap(payload["items"] as? [String])
        XCTAssertEqual(payloadItems.count, 2)
        XCTAssertEqual(payloadItems.first, "a name")
        XCTAssertEqual(payloadItems.last, "other name")
    }
}
