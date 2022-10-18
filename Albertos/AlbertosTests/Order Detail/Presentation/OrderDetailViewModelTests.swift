//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class OrderDetailViewModelTests: XCTestCase {

    func test_headerText() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController())

        XCTAssertEqual(viewModel.headerText, "Your Order")
    }
    
    func test_whenOrderIsEmpty_ShouldNotShowTotalAmount() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController())
        
        XCTAssertNil(viewModel.totalText)
    }

    func test_whenOrderIsNonEmpty_ShouldShowTotalAmount() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(price: 1.0))
        orderController.addToOrder(item: .fixture(price: 2.3))
        let viewModel = OrderDetail.ViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.totalText, "Total: $3.30")
    }

    func test_whenOrderIsEmpty_HasNotItemNamesToShow() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController())

        XCTAssertEqual(viewModel.menuListItems.count, 0)
    }

    func test_whenOrderIsNonEmpty_MenuListItemIsOrderItems() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "a name"))
        orderController.addToOrder(item: .fixture(name: "another name"))
        let viewModel = OrderDetail.ViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.menuListItems.count, 2)
        XCTAssertEqual(viewModel.menuListItems.first?.name, "a name")
        XCTAssertEqual(viewModel.menuListItems.last?.name, "another name")
    }
}
