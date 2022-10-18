//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public class HippoAnalyticsClient {

    public init(apiKey: String) {}

    public func logEvent(named name: String, properties: [String: Any]? = .none) {
        if let properties = properties {
            print("🦛 HippoAnalytics: Logged event named '\(name)' with properties '\(properties)'")
        } else {
            print("🦛 HippoAnalytics: Logged event named '\(name)'")
        }
    }
}
