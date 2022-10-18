//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

extension Order {
    public var hippoPaymentsPayload: [String: Any] { ["items": items.map { $0.name }] }
}
