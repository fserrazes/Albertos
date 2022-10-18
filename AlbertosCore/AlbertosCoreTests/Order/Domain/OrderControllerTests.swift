//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore

final class OrderControllerTests: XCTestCase {
    func test_initsWithEmptyOrder() {
        let controller = OrderController()

        XCTAssertTrue(controller.order.items.isEmpty)
    }
    

}
