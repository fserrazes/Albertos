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
    
    func isItemInOrder(_ item: MenuItem) -> Bool {
        return false
    }
    
    public func addToOrder(item: MenuItem) {
        order = Order(items: order.items + [item])
    }
    
    func removeFromOrder(item: MenuItem) {
        
    }
}
