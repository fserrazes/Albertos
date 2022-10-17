//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation
import AlbertosCore

extension MenuItem {
    public static func fixture(category: String = "category", name: String = "name", spicy: Bool = false, price: Double = 0.0) -> MenuItem {
        MenuItem(category: category, name: name, spicy: spicy, price: price)
    }
    
    public static func jsonFixture(name: String = "any name", category: String = "any category", spicy: Bool = false, price: Double = 0.0) -> String {
        """
        {
            "name": "\(name)",
            "category": "\(category)",
            "spicy": \(spicy),
            "price": \(price)
        }
        """
    }
}
