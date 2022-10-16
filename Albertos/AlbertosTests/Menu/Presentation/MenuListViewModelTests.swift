//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import Combine
import AlbertosCore
@testable import Albertos

final class MenuListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_callsGivenGroupingFunction() throws {
        try XCTSkipIf(true, "skipping this for now, keeping it to reuse part of the code later on")
        
        var called = false
        let inputSections = [MenuSection.fixture()]
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            called = true
            return inputSections
        }
        
        let menuFetchingStub = MenuFetchingStub(returning: .success([.fixture()]))
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub, menuGrouping: spyClosure)
        let sections =  try viewModel.sections.get()
        
        XCTAssertTrue(called, "check that the given closure was called")
        XCTAssertEqual(sections, inputSections, "returns value from closure")
    }
    
    func test_whenFetchingStarts_publishesEmptyMenu() throws {
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingStub(returning: .success([.fixture()])))
        let sections =  try viewModel.sections.get()
        
        XCTAssertTrue(sections.isEmpty)
    }
    
    func test_whenFetchingMenuSucceedsAndGroupingByCategory_publishesSectionsBuiltFromReceivedMenuAndGivenGroupingClosure() {
        var receivedMenu: [MenuItem]?
        let expectedSections = [MenuSection.fixture()]
        
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            receivedMenu = items
            return expectedSections
        }
        
        let expectedMenu = [MenuItem.fixture()]
        let menuFetchingStub = MenuFetchingStub(returning: .success(expectedMenu))
        
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub, menuGrouping: spyClosure)
        let expectation = XCTestExpectation(description: "Publishes sections built from received menu and given grouping closure")
        
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                guard case .success(let sections) = value else {
                    return XCTFail("Expected a successful result, got: \(value) instead")
                }
                
                // Ensure the grouping closure is called with the received menu
                XCTAssertEqual(receivedMenu, expectedMenu)
                
                // Ensure the published value is the result of the grouping closure
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenFetchingFails_publishesAnError() {
        
    }
    
}

extension MenuItem: Equatable {
    public static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.id == rhs.id
    }
}
extension MenuSection: Equatable {
    public static func == (lhs: AlbertosCore.MenuSection, rhs: AlbertosCore.MenuSection) -> Bool {
        return lhs.id == rhs.id
    }
}
