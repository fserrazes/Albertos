//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

@main
struct AlbertosApp: App {
    let orderController = OrderController()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(viewModel: .init(menuFetching: MenuFetcher()))
                    .navigationTitle("Alberto's 🇮🇹")
            }
            .environmentObject(orderController)
        }
    }
}
