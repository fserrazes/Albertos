//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import Combine
import AlbertosCore

struct MenuItemDetail: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension MenuItemDetail {
    class ViewModel {
        private let item: MenuItem
        private let orderController: OrderController
        
        // TODO: Using default value for OrderController while working on the ViewModel implementation.
        // We'll remove it once done and inject it from the view.
        @Published private(set) var addOrRemoveFromOrderButtonText = "Remove from order"
        
        private var cancellables = Set<AnyCancellable>()
        
        init(item: MenuItem, orderController: OrderController = OrderController()) {
            self.item = item
            self.orderController = orderController
            
            self.orderController.$order
                .sink { [weak self] order in
                    guard let self = self else { return }

                    if (order.items.contains { $0 == self.item }) {
                        self.addOrRemoveFromOrderButtonText = "Remove from order"
                    } else {
                        self.addOrRemoveFromOrderButtonText = "Add to order"
                    }
                }
                .store(in: &cancellables)
        }
        
        func addOrRemoveFromOrder() {
            if (orderController.order.items.contains { $0 == item }) {
                orderController.removeFromOrder(item: item)
            } else {
                orderController.addToOrder(item: item)
            }
        }
    }
}

struct MenuItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetail()
    }
}
