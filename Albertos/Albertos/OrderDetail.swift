//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct OrderDetail: View {
    let viewModel: ViewModel

    var body: some View {
        Text(viewModel.headerText)
    }
}

import AlbertosCore

extension OrderDetail {
    struct ViewModel {
        let headerText = "Your Order"
        let menuListItems: [MenuItem]
        let totalText: String?
        
        init(orderController: OrderController) {
            self.totalText = orderController.order.items.isEmpty ?
                .none : "Total: $\(String(format: "%.2f", orderController.order.total))"
            
            self.menuListItems = orderController.order.items
        }
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail(viewModel: .init(orderController: OrderController()))
    }
}
