//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import Combine
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
    
    // MARK: - Proccessing Payments
    
    func test_whenCheckoutButtonTapped_StartsPaymentProcessingFlow() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "name"))
        orderController.addToOrder(item: .fixture(name: "other name"))
        
        let paymentProcessingSpy = PaymentProcessingSpy()
        
        let viewModel = OrderDetail.ViewModel( orderController: orderController, paymentProcessor: paymentProcessingSpy)
        viewModel.checkout()
        
        XCTAssertEqual(paymentProcessingSpy.receivedOrder,orderController.order)
    }
    
    // MARK: - Helpers
    
    private class PaymentProcessingSpy: PaymentProcessing {
        private(set) var receivedOrder: Order?

        func process(order: Order) -> AnyPublisher<Void, Error> {
            receivedOrder = order
            return Result<Void, Error>.success(()).publisher.eraseToAnyPublisher()
        }
    }
}

extension Order: Equatable {
    public static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.items == rhs.items
    }
}
