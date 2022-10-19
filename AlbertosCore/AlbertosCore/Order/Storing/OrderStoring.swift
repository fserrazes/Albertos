//  Created on 19.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public protocol OrderStoring {
    func getOrder() -> Order
    func updateOrder(_ order: Order)
}
