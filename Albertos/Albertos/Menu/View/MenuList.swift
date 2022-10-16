//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore
import Combine

struct MenuList: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
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
    class ViewModel: ObservableObject {
        @Published private (set) var sections: [MenuSection]

        private  var cancellables = Set<AnyCancellable>()
        
        init(menuFetching: MenuFetching,
             menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
            self.sections = []
            menuFetching
                .fetchMenu()
                .sink( receiveCompletion: { _ in },
                       receiveValue: { [weak self] value in
                    self?.sections = menuGrouping(value)
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
