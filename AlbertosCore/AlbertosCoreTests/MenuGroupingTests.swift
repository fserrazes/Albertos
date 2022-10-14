//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest

struct MenuItem {
    let category: String
    let name: String
}

struct MenuSection {
    let items: [MenuItem]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
    guard menu.isEmpty == false else { return [] }
    
    return [MenuSection(items: menu)]
}
final class MenuGroupingTests: XCTestCase {
    
    func test_menuWithManyCategories_returnsOneSectionPerCategory() {
        
    }
    
    func test_menuWithOneCategory_returnsOneSection() throws {
        let menu = [
            MenuItem(category: "pastas", name: "name"),
            MenuItem(category: "pastas", name: "other name")
        ]
        
        let sections = groupMenuByCategory(menu)
        
        XCTAssertEqual(sections.count, 1)
        let section = try XCTUnwrap(sections.first)
        XCTAssertEqual(section.items.first?.name, "name")
        XCTAssertEqual(section.items.last?.name, "other name")
    }
    
    func test_emptyMenu_returnsEmptySections() {
        let menu = [MenuItem]()
        
        let sections = groupMenuByCategory(menu)
        
        XCTAssertTrue(sections.isEmpty)
    }
}
