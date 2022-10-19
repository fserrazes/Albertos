//  Created on 19.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

fileprivate var orderKey = "order"

extension UserDefaults: OrderStoring {
    public func getOrder() -> Order {
        guard let data = data(forKey: orderKey), let order = try? JSONDecoder().decode(Order.self, from: data) else {
            let order = Order(items: [])
            updateOrder(order)
            return order
        }
        return order
    }

    public func updateOrder(_ order: Order) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(order) else { return }
        setValue(data, forKey: orderKey)
    }
}

extension Order: Codable {
    enum CodingKeys: CodingKey {
      case items, total
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([MenuItem].self, forKey: .items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }
}
