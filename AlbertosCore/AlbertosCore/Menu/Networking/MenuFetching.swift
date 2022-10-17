//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import Foundation

public protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
