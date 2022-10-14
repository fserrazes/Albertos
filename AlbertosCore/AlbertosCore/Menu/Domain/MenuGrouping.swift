//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return Dictionary(grouping: menu, by: { $0.category }).map { key, value in
        MenuSection(category: key, items: value)
    }.sorted { $0.category > $1.category }
}
