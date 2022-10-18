//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import Combine
import AlbertosCore

struct MenuItemDetail: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.name)
                .fontWeight(.bold)

            if let spicy = viewModel.spicy {
                Text(spicy)
                    .font(Font.body.italic())
            }

            Text(viewModel.price)

            Button(viewModel.addOrRemoveFromOrderButtonText) {
                viewModel.addOrRemoveFromOrder()
            }

            Spacer()
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

extension MenuItemDetail {
    class ViewModel: ObservableObject {
        private let item: MenuItem
        private let orderController: OrderController
        
        let name: String
        let spicy: String?
        let price: String
        
        // TODO: Using default value for OrderController while working on the ViewModel implementation.
        // We'll remove it once done and inject it from the view.
        @Published private(set) var addOrRemoveFromOrderButtonText = "Remove from order"
        
        private var cancellables = Set<AnyCancellable>()
        
        init(item: MenuItem, orderController: OrderController = OrderController()) {
            self.item = item
            self.orderController = orderController
            
            name = item.name
            spicy = item.spicy ? "Spicy" : .none
            price = "$\(String(format: "%.2f", item.price))"
            
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
        let item = MenuItem(category: "some category", name: "any name", spicy: true, price: 0.99)
        MenuItemDetail(viewModel: .init(item: item))
    }
}
