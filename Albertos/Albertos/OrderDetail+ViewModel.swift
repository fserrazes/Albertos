//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import AlbertosCore
import HippoPayments

extension OrderDetail {
    struct ViewModel {
        let headerText = "Your Order"
        let emptyMenuFallbackText = "Add dishes to the order to see them here!"
        let menuListItems: [MenuItem]
        let totalText: String?
        
        let shouldShowCheckoutButton: Bool
        let checkoutButtonText = "Checkout"
        
        private let orderController: OrderController
        private let paymentProcessor: PaymentProcessing
        
        // TODO: Using a default value for HippoPaymentsProcessor // only to make the code compile.
        // We'll remove it once fully integrated.
        
        init(orderController: OrderController, paymentProcessor: PaymentProcessing = HippoPaymentsProcessor.init(apiKey: "A1B2C3")) {
            self.orderController = orderController
            self.paymentProcessor = paymentProcessor
            
            if orderController.order.items.isEmpty {
                totalText = .none
                shouldShowCheckoutButton = false
            } else {
                totalText = "Total: $\(String(format: "%.2f", orderController.order.total))"
                shouldShowCheckoutButton = true
            }
            
            self.menuListItems = orderController.order.items
        }
        
        func checkout() {
            paymentProcessor.process(order: orderController.order)
        }
    }
}
