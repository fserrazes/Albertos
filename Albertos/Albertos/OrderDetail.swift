//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct OrderDetail: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(viewModel.headerText)
                .font(.title)
                .padding(.top)
            
            if viewModel.menuListItems.isEmpty {
                Text(viewModel.emptyMenuFallbackText)
                    .multilineTextAlignment(.center)
            } else {
                List(viewModel.menuListItems) { Text($0.name) }
            }
            
            if let total = viewModel.totalText {
                Text(total)
            }
            
            Spacer()
        }
    }
}

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

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail(viewModel: .init(orderController: OrderController()))
    }
}
