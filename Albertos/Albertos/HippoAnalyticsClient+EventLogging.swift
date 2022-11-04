//  Created on 04.11.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation
import HippoAnalytics

extension HippoAnalyticsClient: EventLogging {
    public func log(name: String, properties: [String : Any]) {
        logEvent(named: name, properties: properties)
    }
}
