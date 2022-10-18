//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct OrderDetail: View {
    let viewModel: ViewModel

    var body: some View {
        Text(viewModel.text)
    }
}

import AlbertosCore

extension OrderDetail {
    struct ViewModel {
        let text = "Order Detail"
        let totalText: String?
        
        init(orderController: OrderController) {
            self.totalText = orderController.order.items.isEmpty ?
                .none : "Total: $\(String(format: "%.2f", orderController.order.total))"
        }
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail(viewModel: .init(orderController: OrderController()))
    }
}
