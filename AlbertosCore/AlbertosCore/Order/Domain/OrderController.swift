//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public class OrderController: ObservableObject {
    @Published public private(set) var order: Order
    
    public var items: [MenuItem] { order.items }
    public var total: Double { order.total }
    
    public init(order: Order = Order(items: [])) {
        self.order = order
    }
    
    public func isItemInOrder(_ item: MenuItem) -> Bool {
        return order.items.contains { $0 == item }
    }
    
    public func addToOrder(item: MenuItem) {
        order = Order(items: order.items + [item])
    }
    
    public func removeFromOrder(item: MenuItem) {
        let items = order.items
        guard let indexToRemove = items.firstIndex(where: { $0.name == item.name }) else { return }

        let newItems = items.enumerated().compactMap { (index, element) -> MenuItem? in
            guard index == indexToRemove else { return element }
            return .none
        }

        order = Order(items: newItems)
    }
    
    public func resetOrder() {
        order = Order(items: [])
    }
}
