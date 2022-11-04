//  Created on 04.11.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public protocol EventLogging {
    func log(name: String, properties: [String: Any])
}
