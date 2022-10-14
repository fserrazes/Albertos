//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

struct MenuRow: View {
    let item: MenuItem
    
    var body: some View {
        Text(item.name)
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        let item = MenuItem(category: "some category", name: "any name", spicy: true, price: 0.99)
        MenuRow(item: item)
    }
}
