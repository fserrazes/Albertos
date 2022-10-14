//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public struct MenuSection {
    public let category: String
    public let items: [MenuItem]

    public init(category: String, items: [MenuItem]) {
        self.category = category
        self.items = items
    }
}
