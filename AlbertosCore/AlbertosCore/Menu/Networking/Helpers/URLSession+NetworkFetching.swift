//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import Foundation

extension URLSession: NetworkFetching {
    public func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
