//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import AlbertosCore
import HippoPayments

extension HippoPaymentsProcessor: PaymentProcessing {
    func process(order _: Order) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.processPayment(payload: ["items": ["Arancini Balls", "Penne all'Arrabbiata"]],
                onSuccess: { promise(.success(())) },
                onFailure: { promise(.failure($0)) }
            )
        }
        .eraseToAnyPublisher()
    }
}


