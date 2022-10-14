//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest

struct MenuItem {}
struct MenuSection {}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    return []
}
final class MenuGroupingTests: XCTestCase {
    
    func test_menuWithManyCategories_returnsOneSectionPerCategory() {
        
    }
    
    func test_menuWithOneCategory_returnsOneSection() {
        
    }
    
    func test_emptyMenu_returnsEmptySections() {
        let menu = [MenuItem]()
        
        let sections = groupMenuByCategory(menu)
        
        XCTAssertTrue(sections.isEmpty)
    }
}
