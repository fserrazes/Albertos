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
}
