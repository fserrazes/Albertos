//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

struct MenuRow: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}

extension MenuRow {
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.spicy ? "\(item.name) 🌶" : item.name
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        let item = MenuItem(category: "some category", name: "any name", spicy: true, price: 0.99)
        MenuRow(viewModel: .init(item: item))
    }
}
