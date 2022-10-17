//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public class OrderController: ObservableObject {
    @Published private(set) var order: Order
    
    public init(order: Order = Order(items: [])) {
        self.order = order
    }
    
    func isItemInOrder(_ item: MenuItem) -> Bool {
        return false
    }
    
    public func addToOrder(item: MenuItem) {
        
    }
    
    func removeFromOrder(item: MenuItem) {
        
    }
}
