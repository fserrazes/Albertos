//  Created on 20.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import SwiftUI
import AlbertosCore
@testable import Albertos

final class OrderDetailSnapshotTests: XCTestCase {

    func test_orderDetail_withEmptyOrder() throws {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)),
               named: "IMAGE_ORDER_DETAIL_WITH_NO_ITEMS_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)),
               named: "IMAGE_ORDER_DETAIL_WITH_NO_ITEMS_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)),
               named: "IMAGE_ORDER_DETAIL_WITH_NO_ITEMS_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers

    private func makeSUT() -> (UIHostingController<OrderDetail>) {
        let controller = OrderController(orderStoring: OrderStoringFake())
        let sut = OrderDetail(viewModel: .init(orderController: controller,
                                               paymentProcessor: previewPaymentProcessor, onAlertDismiss: {}))
        
        return UIHostingController(rootView: sut)
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
