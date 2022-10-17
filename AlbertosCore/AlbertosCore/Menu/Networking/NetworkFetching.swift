//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import Foundation

public protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}
