//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import Foundation
import AlbertosCore

class MenuFetchingPlaceholder: MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        return Future { $0(.success(menu)) }
        // Use a delay to simulate async fetch
        .delay(for: 0.5, scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
