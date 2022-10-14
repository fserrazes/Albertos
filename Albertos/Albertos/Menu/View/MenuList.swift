//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

struct MenuList: View {
    let sections: [MenuSection]
    
    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.category)) {
                    ForEach(section.items) { item in Text(item.name)
                    }
                }
            }
        }
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
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
        
        MenuList(sections: groupMenuByCategory(menu))
    }
}
