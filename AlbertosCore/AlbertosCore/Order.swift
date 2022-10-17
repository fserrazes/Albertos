//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public struct Order {
    public let items: [MenuItem]
    public var total: Double { items.reduce(0) { $0 + $1.price } }
    
    public init(items: [MenuItem]) {
        self.items = items
    }
}
