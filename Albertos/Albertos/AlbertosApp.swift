//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

public let menu = [
    MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 3.45),
    MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 4.56),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 8.90),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 9.10),
    MenuItem(category: "drinks", name: "Water", spicy: false, price: 2.34),
    MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 3.45),
    MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 5.43),
    MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 4.68),
]

@main
struct AlbertosApp: App {
    // In this first iteration the menu is an hard-coded array
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(sections: groupMenuByCategory(menu))
                    .navigationTitle("Alberto's 🇮🇹")
            }
        }
    }
}
