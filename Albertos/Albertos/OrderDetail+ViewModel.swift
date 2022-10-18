//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import Combine
import AlbertosCore
import HippoPayments

extension OrderDetail {
    class ViewModel: ObservableObject {
        @Published var alertToShow: Alert.ViewModel?
        
        let headerText = "Your Order"
        let emptyMenuFallbackText = "Add dishes to the order to see them here"
        let menuListItems: [MenuItem]
        let totalText: String?
        
        let shouldShowCheckoutButton: Bool
        let checkoutButtonText = "Checkout"
        
        private let orderController: OrderController
        private let paymentProcessor: PaymentProcessing
        private var cancellables = Set<AnyCancellable>()
        
        init(orderController: OrderController, paymentProcessor: PaymentProcessing) {
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
                .sink(receiveCompletion: { [weak self] completion in
                    guard case .failure = completion else { return }
                    
                    self?.alertToShow = Alert.ViewModel(title: "",
                                                        message: "There's been an error with your order. Please contact a waiter.",
                                                        buttonText: "Ok")
                }, receiveValue: { _ in
                })
                .store(in: &cancellables)

        }
    }
}
