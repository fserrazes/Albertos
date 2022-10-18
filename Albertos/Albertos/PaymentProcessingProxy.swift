//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import AlbertosCore
import HippoPayments

/// Wraps `HippoPaymentsProcessors` into a type in our domain so we don't have to `import` the
/// framework in every SwiftUI view that uses. This is a workaround to the fact that
/// `environmentObject(_:)` requires a type conforming to `ObservableObject` so we cannot pass it a
/// value defined as `PaymentProcessing` because "only struct/enum/class types can conform to protocols".
public class PaymentProcessingProxy: PaymentProcessing, ObservableObject {
    private let proxiedProcessor: PaymentProcessing = HippoPaymentsProcessor(apiKey: "abcd")

    func process(order: Order) -> AnyPublisher<Void, Error> {
        proxiedProcessor.process(order: order)
    }
}
