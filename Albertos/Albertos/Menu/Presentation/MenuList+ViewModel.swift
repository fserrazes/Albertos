//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import AlbertosCore

extension MenuList {
    class ViewModel: ObservableObject {
        @Published private (set) var sections: Result<[MenuSection], Error> = .success([])

        private var cancellables = Set<AnyCancellable>()
        
        init(menuFetcher: AnyPublisher<[MenuItem], Error>,
             menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
            menuFetcher
                .map(menuGrouping)
                .receive(on: DispatchQueue.main)
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
