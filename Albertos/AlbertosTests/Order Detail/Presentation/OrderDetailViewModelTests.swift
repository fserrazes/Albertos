//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import Combine
import AlbertosCore
@testable import Albertos

final class OrderDetailViewModelTests: XCTestCase {

    func test_headerText() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              paymentProcessor: PaymentProcessingSpy(), onAlertDismiss: {})

        XCTAssertEqual(viewModel.headerText, "Your Order")
    }
    
    func test_emptyMenu_FallbackText() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              paymentProcessor: PaymentProcessingSpy(), onAlertDismiss: {})

        XCTAssertEqual(viewModel.emptyMenuFallbackText, "Add dishes to the order to see them here")
    }
    
    func test_whenOrderIsEmpty_ShouldNotShowTotalAmount() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              paymentProcessor: PaymentProcessingSpy(), onAlertDismiss: {})
        
        XCTAssertNil(viewModel.totalText)
    }

    func test_whenOrderIsNonEmpty_ShouldShowTotalAmount() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(price: 1.0))
        orderController.addToOrder(item: .fixture(price: 2.3))
        let viewModel = OrderDetail.ViewModel(orderController: orderController,
                                              paymentProcessor: PaymentProcessingSpy(), onAlertDismiss: {})

        XCTAssertEqual(viewModel.totalText, "Total: $3.30")
    }

    func test_whenOrderIsEmpty_HasNotItemNamesToShow() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              paymentProcessor: PaymentProcessingSpy(), onAlertDismiss: {})

        XCTAssertEqual(viewModel.menuListItems.count, 0)
    }

    func test_whenOrderIsNonEmpty_MenuListItemIsOrderItems() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "a name"))
        orderController.addToOrder(item: .fixture(name: "another name"))
        let viewModel = OrderDetail.ViewModel(orderController: orderController,
                                              paymentProcessor: PaymentProcessingSpy(), onAlertDismiss: {})

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
        
        let viewModel = OrderDetail.ViewModel(orderController: orderController,
                                              paymentProcessor: paymentProcessingSpy, onAlertDismiss: {})
        viewModel.checkout()
        
        XCTAssertEqual(paymentProcessingSpy.receivedOrder,orderController.order)
    }
    
    func test_whenPaymentSucceeds_UpdatesPropertyToShowConfirmationAlert() {
        var called = false
        let paymentProcessingStub = PaymentProcessingStub(returning: .success(()))
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              paymentProcessor: paymentProcessingStub,
                                              onAlertDismiss: { called = true })
        
        // Use XCTNSPredicateExpectation because we cannot explicitly fulfill an expectation once the async code under test has no callback
        let predicate = NSPredicate { _, _ in viewModel.alertToShow != nil }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        
        viewModel.checkout()
        
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        
        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(viewModel.alertToShow?.message, "The payment was successful. Your food will be with you shortly.")
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")
        
        viewModel.alertToShow?.buttonAction?()
        XCTAssertTrue(called)
    }
    
    func test_whenPaymentFails_UpdatesPropertyToShowErrorAlert() {
        var called = false
        let paymentProcessingStub = PaymentProcessingStub(returning: .failure(anyNSError))
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              paymentProcessor: paymentProcessingStub,
                                              onAlertDismiss: { called = true })
        
        // Use XCTNSPredicateExpectation because we cannot explicitly fulfill an expectation once the async code under test has no callback
        let predicate = NSPredicate { _, _ in viewModel.alertToShow != nil }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        
        viewModel.checkout()
        
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        
        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(viewModel.alertToShow?.message, "There's been an error with your order. Please contact a waiter.")
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")
        
        viewModel.alertToShow?.buttonAction?()
        XCTAssertTrue(called)
    }
    
    func test_whenPaymentSucceeds_DismissingTheAlertResetsTheOrder() {
        // Arrange the input state with a valid order, one that has items
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture())
        let paymentProcessingStub = PaymentProcessingStub(returning: .success(()))
        let viewModel = OrderDetail.ViewModel(orderController: orderController,
                                              paymentProcessor: paymentProcessingStub,
                                              onAlertDismiss: { })
        
        // Perform the checkout and wait for it to succeed
        let predicate = NSPredicate { _, _ in viewModel.alertToShow != nil }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        
        viewModel.checkout()
        
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        
        // Run the alert dismiss code
        viewModel.alertToShow?.buttonAction?()
        
        // Verify the order has been reset
        XCTAssertTrue(orderController.order.items.isEmpty)
    }
    
    // MARK: - Helpers
    
    private class PaymentProcessingSpy: PaymentProcessing {
        private(set) var receivedOrder: Order?

        func process(order: Order) -> AnyPublisher<Void, Error> {
            receivedOrder = order
            return Result<Void, Error>.success(()).publisher.eraseToAnyPublisher()
        }
    }
    
    private class PaymentProcessingStub: PaymentProcessing {
        let result: Result<Void, Error>
        
        init(returning result: Result<Void, Error>) {
            self.result = result
        }
        
        func process(order: Order) -> AnyPublisher<Void, Error> {
            return result.publisher
            // Use a delay to simulate the real world async behavior
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }
    
    //Using a wait time of around 1 second seems to result in occasional test timeout failures when using `XCTNSPredicateExpectation`.
    private var timeoutForPredicateExpectations: Double { 2.0 }
}

extension Order: Equatable {
    public static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.items == rhs.items
    }
}
