//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import AlbertosCore

extension OrderDetail {
    struct ViewModel {
        let headerText = "Your Order"
        let emptyMenuFallbackText = "Add dishes to the order to see them here!"
        let menuListItems: [MenuItem]
        let totalText: String?
        
        init(orderController: OrderController) {
            self.totalText = orderController.order.items.isEmpty ?
                .none : "Total: $\(String(format: "%.2f", orderController.order.total))"
            
            self.menuListItems = orderController.order.items
        }
    }
}
