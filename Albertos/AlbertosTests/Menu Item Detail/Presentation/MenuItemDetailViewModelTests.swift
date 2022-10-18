//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class MenuItemDetailViewModelTests: XCTestCase {

    func test_whenItemIsInOrder_ButtonSaysRemove() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        let text = viewModel.addOrRemoveFromOrderButtonText
        
        XCTAssertEqual(text, "Remove from order")
    }
    
    func test_whenItemIsNotInOrder_ButtonSaysAdd() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)

        let text = viewModel.addOrRemoveFromOrderButtonText
        
        XCTAssertEqual(text, "Add to order")
    }
    
    func test_whenItemIsInOrder_ButtonActionRemovesIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        viewModel.addOrRemoveFromOrder()
        
        XCTAssertFalse(orderController.order.items.contains { $0 ==
        item })
    }
    
    func test_whenItemIsNotInOrder_ButtonActionAddsIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)

        viewModel.addOrRemoveFromOrder()

        XCTAssertTrue(orderController.order.items.contains { $0 == item })
    }
    
    func test_Name_IsItemName() {
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(name: "a name"),
                          orderController: OrderController()).name, "a name")
    }

    func test_whenItemIsSpicy_ShowsSpicyMessage() {
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(spicy: true),
                          orderController: OrderController()).spicy, "Spicy")
    }

    func test_whenItemIsNotSpicy_DoesNotShowSpicyMessage() {
        XCTAssertNil(MenuItemDetail.ViewModel(item: .fixture(spicy: false),
                                   orderController: OrderController()).spicy)
    }

    func test_priceIsFormatted_itemPrice() {
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 1.0),
                          orderController: OrderController()).price, "$1.00")
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 2.5),
                          orderController: OrderController()).price, "$2.50")
        
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 3.45),
                          orderController: OrderController()).price, "$3.45")
        
        XCTAssertEqual(
            MenuItemDetail.ViewModel(item: .fixture(price: 4.123),
                          orderController: OrderController()).price, "$4.12")
    }
}
