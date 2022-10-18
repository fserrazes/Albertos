//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import AlbertosCore

extension OrderButton {
    class ViewModel {
        @Published private(set) var text = "Your Order"
        
        private(set) var cancellables = Set<AnyCancellable>()
        
        init(orderController: OrderController) {
            orderController.$order
                .sink { [weak self] order in
                    self?.text = order.items.isEmpty ? "Your Order" : "Your Order $\(String(format: "%.2f", order.total))"
                }
                .store(in: &cancellables)
        }
    }
}
