//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

struct MenuItemDetail: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension MenuItemDetail {
    struct ViewModel {
        private let item: MenuItem
        private let orderController: OrderController
        
        // TODO: Using default value for OrderController while working on the ViewModel implementation.
        // We'll remove it once done and inject it from the view.
        let addOrRemoveFromOrderButtonText = "Remove from order"
        
        
        init(item: MenuItem, orderController: OrderController = OrderController()) {
            self.item = item
            self.orderController = orderController
        }
    }
}
struct MenuItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetail()
    }
}
