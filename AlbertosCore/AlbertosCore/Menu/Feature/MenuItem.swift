//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Foundation

public struct MenuItem: Identifiable {
    public var id: String { name }
    
    public let category: String
    public let name: String
    
    public init(category: String, name: String) {
        self.category = category
        self.name = name
    }
}
