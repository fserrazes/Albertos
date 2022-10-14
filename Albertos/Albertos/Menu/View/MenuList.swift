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
                    ForEach(section.items) { item in
                        MenuRow(viewModel: .init(item: item))
                    }
                }
            }
        }
    }
}

extension MenuList {
    struct ViewModel {
        let sections: [MenuSection]
        
        init(menu: [MenuItem],
             menuGrouping: @escaping ([MenuItem]) -> [MenuSection]) {
            self.sections = menuGrouping(menu)
        }
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        MenuList(sections: groupMenuByCategory(menu))
    }
}
