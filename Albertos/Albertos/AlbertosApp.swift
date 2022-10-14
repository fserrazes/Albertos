//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

@main
struct AlbertosApp: App {
    // In this first iteration the menu is an hard-coded array
    let menu = [
        MenuItem(category: "starters", name: "Caprese Salad"),
        MenuItem(category: "starters", name: "Arancini Balls"),
        MenuItem(category: "pastas", name: "Penne all'Arrabbiata"),
        MenuItem(category: "pastas", name: "Spaghetti Carbonara"),
        MenuItem(category: "drinks", name: "Water"),
        MenuItem(category: "drinks", name: "Red Wine"),
        MenuItem(category: "desserts", name: "Tiramisù"),
        MenuItem(category: "desserts", name: "Crema Catalana")
    ]
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(sections: groupMenuByCategory(menu))
                    .navigationTitle("Alberto's 🇮🇹")
            }
        }
    }
}
