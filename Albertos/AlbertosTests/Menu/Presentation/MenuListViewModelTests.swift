//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class MenuListViewModelTests: XCTestCase {

    func test_callsGivenGroupingFunction() throws {
        try XCTSkipIf(true, "skipping this for now, keeping it to reuse part of the code later on")
        
        var called = false
        let inputSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            called = true
            return inputSections
        }
        let viewModel = MenuList.ViewModel(menu: [.fixture()], menuGrouping: spyClosure)
        let sections = viewModel.sections
        
        XCTAssertTrue(called, "check that the given closure was called")
        XCTAssertEqual(sections, inputSections, "returns value from closure")
    }
    
    func test_whenFetchingStarts_publishesEmptyMenu() {
        let viewModel = MenuList.ViewModel(menu: [.fixture()])
        
        XCTAssertTrue(viewModel.sections.isEmpty)
    }
    
    func test_whenFecthingMenuSucceedsAndGroupingByCategory_publishesSectionsBuiltFromReceivedMenu() {
        
    }
    
    func test_whenFetchingFails_publishesAnError() {
        
    }
    
}

extension MenuSection: Equatable {
    public static func == (lhs: AlbertosCore.MenuSection, rhs: AlbertosCore.MenuSection) -> Bool {
        return lhs.id == rhs.id
    }
}
