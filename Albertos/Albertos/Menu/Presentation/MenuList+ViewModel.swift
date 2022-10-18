//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import AlbertosCore

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