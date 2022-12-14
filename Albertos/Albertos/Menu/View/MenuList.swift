//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

struct MenuList: View {
    @ObservedObject var viewModel: ViewModel
    var orderController: OrderController
    
    var body: some View {
        switch viewModel.sections {
            case .success(let sections):
                List {
                    ForEach(sections) { section in
                        Section(header: Text(section.category)) {
                            ForEach(section.items) { item in
                                NavigationLink(destination: destination(for: item)) {
                                    MenuRow(viewModel: .init(item: item))
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                Text("An error occurred:")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .italic()
                    .padding(10)
        }
    }
    
    func destination(for item: MenuItem) -> MenuItemDetail {
        return MenuItemDetail(viewModel: .init(item: item, orderController: orderController))
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        MenuList(viewModel: .init(menuFetcher: MenuFetchingPlaceholder().fetchMenu()), orderController: previewOrderController)
    }
}

