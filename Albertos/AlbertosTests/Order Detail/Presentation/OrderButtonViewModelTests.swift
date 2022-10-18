//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class OrderButtonViewModelTests: XCTestCase {

    func test_whenOrderIsEmpty_doesNotShowTotal() {
        let orderController = OrderController()
        let viewModel = OrderButton.ViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.text, "Your Order")
    }

    func test_whenOrderIsNotEmpty_showsTotal() {
        
    }
}
