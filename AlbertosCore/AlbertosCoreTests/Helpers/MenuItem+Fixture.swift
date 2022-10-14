//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation
import AlbertosCore

extension MenuItem {
    public static func fixture(category: String = "category", name: String = "name", spicy: Bool = false) -> MenuItem {
        MenuItem(category: category, name: name, spicy: spicy)
    }
}
    
