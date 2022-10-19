//  Created on 19.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation
import AlbertosCore

public class OrderStoringFake: OrderStoring {
    private var order: Order = Order(items: [])

    public func getOrder() -> Order {
        return order
    }

    public func updateOrder(_ order: Order) {
        self.order = order
    }
}
