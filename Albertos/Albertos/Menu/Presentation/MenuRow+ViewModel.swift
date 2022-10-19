//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation
import AlbertosCore

extension MenuRow {
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.spicy ? "\(item.name) 🔥" : item.name
        }
    }
}
