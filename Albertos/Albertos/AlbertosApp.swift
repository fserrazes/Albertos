//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

private let menuFectherLoader = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://s3.amazonaws.com/mokacoding/menu_response.json")!)
    .map(\.data)
    .decode(type: [MenuItem].self, decoder: JSONDecoder())
    .eraseToAnyPublisher()

@main
struct AlbertosApp: App {
    let orderController = OrderController()
    let paymentProcessor = PaymentProcessingProxy()
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                NavigationStack {
                    MenuList(viewModel: .init(menuFetcher: menuFectherLoader))
                        .navigationTitle("Alberto's 🇮🇹")
                }
                OrderButton(viewModel: .init(orderController: orderController))
                    .padding(10)
            }
            .environmentObject(orderController)
            .environmentObject(paymentProcessor)
        }
    }
}
