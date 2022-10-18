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
        
        private var cancellables = Set<AnyCancellable>()
        private let orderController: OrderController
        private let paymentProcessor: PaymentProcessing
        private let onAlertDismiss: () -> Void
        
        init(orderController: OrderController, paymentProcessor: PaymentProcessing, onAlertDismiss: @escaping () -> Void) {
            self.orderController = orderController
            self.paymentProcessor = paymentProcessor
            self.onAlertDismiss = onAlertDismiss
            
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
                    
                    let message = "There's been an error with your order. Please contact a waiter."
                    self?.alertToShow = Alert.ViewModel(title: "", message: message, buttonText: "Ok", buttonAction: self?.onAlertDismiss)
                }, receiveValue: { [weak self] _ in
                    let message = "The payment was successful. Your food will be with you shortly."
                    self?.alertToShow = Alert.ViewModel(title: "", message: message, buttonText: "Ok", buttonAction: self?.onAlertDismiss)
                })
                .store(in: &cancellables)

        }
    }
}
