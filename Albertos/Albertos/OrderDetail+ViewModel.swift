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
        
        private let orderController: OrderController
        private let paymentProcessor: PaymentProcessing
        
        // TODO: Using a default value for HippoPaymentsProcessor // only to make the code compile.
        // We'll remove it once fully integrated.
        
        init(orderController: OrderController, paymentProcessor: PaymentProcessing = HippoPaymentsProcessor.init(apiKey: "A1B2C3")) {
            self.orderController = orderController
            self.paymentProcessor = paymentProcessor
            
            self.totalText = orderController.order.items.isEmpty ?
                .none : "Total: $\(String(format: "%.2f", orderController.order.total))"
            
            self.menuListItems = orderController.order.items
        }
    }
}
