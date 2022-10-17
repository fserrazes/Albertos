//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public struct MenuItem: Identifiable, Decodable {
    public var id: String { name }
    
    public let category: String
    public let name: String
    public let spicy: Bool
    public let price: Double
    
    public init(category: String, name: String, spicy: Bool, price: Double) {
        self.category = category
        self.name = name
        self.spicy = spicy
        self.price = price
    }
}

extension MenuItem: Equatable {
    public static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.id == rhs.id
    }
}
