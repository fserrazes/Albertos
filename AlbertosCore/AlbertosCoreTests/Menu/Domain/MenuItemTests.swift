//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
                        
final class MenuItemTests: XCTestCase {
    
    func test_whenDecodedFromJSONData_hasAllTheInputProperties() throws {
        let json = #"{ "name": "a name", "category": "a category", "spicy": true }"#
        let data = try XCTUnwrap(json.data(using: .utf8))
        
        let item = try JSONDecoder() .decode(MenuItem.self, from: data)
        
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
    }
}
