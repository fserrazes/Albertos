//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import AlbertosCore

protocol PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, Error>
}
