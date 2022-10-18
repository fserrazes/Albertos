//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore
import Combine

struct MenuList: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var orderController: OrderController
    
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
        }
    }
    
    func destination(for item: MenuItem) -> MenuItemDetail {
        return MenuItemDetail(viewModel: .init(item: item, orderController: orderController))
    }
}

extension MenuList {
    class ViewModel: ObservableObject {
        @Published private (set) var sections: Result<[MenuSection], Error> = .success([])

        private  var cancellables = Set<AnyCancellable>()
        
        init(menuFetching: MenuFetching,
             menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
            menuFetching
                .fetchMenu()
                .map(menuGrouping)
                .sink( receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    self?.sections = .failure(error)
                },
                receiveValue: { [weak self] value in
                    self?.sections = .success(value)
                })
                .store(in: &cancellables)

        }
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
    }
}
