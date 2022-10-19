//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public class OrderController: ObservableObject {
    @Published public private(set) var order: Order
    private let orderStoring: OrderStoring
    
    public init(orderStoring: OrderStoring = UserDefaults.standard) {
        self.orderStoring = orderStoring
        order = orderStoring.getOrder()
    }
    
    public func isItemInOrder(_ item: MenuItem) -> Bool {
        return order.items.contains { $0 == item }
    }
    
    public func addToOrder(item: MenuItem) {
        updateOrder(with: Order(items: order.items + [item]))
    }
    
    public func removeFromOrder(item: MenuItem) {
        let items = order.items
        guard let indexToRemove = items.firstIndex(where: { $0.name == item.name }) else { return }

        let newItems = items.enumerated().compactMap { (index, element) -> MenuItem? in
            guard index == indexToRemove else { return element }
            return .none
        }

        updateOrder(with: Order(items: newItems))
    }
    
    public func resetOrder() {
        updateOrder(with: Order(items: []))
    }
    
    private func updateOrder(with newOrder: Order) {
        orderStoring.updateOrder(newOrder)
        order = newOrder
    }
}
