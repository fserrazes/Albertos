//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import Foundation
import AlbertosCore

public class NetworkFetchingStub: NetworkFetching {

    private let result: Result<Data, URLError>

    public init(returning result: Result<Data, URLError>) {
        self.result = result
    }

    public func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result.publisher
            // Use a delay to simulate the real world async behavior
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
