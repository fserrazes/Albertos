//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import Combine
import AlbertosCore
@testable import Albertos

final class MenuListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
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
        let expectedError = anyNSError
        let menuFetchingStub = MenuFetchingStub(returning: .failure(expectedError))
        
        let viewModel = MenuList.ViewModel(menuFetching: menuFetchingStub, menuGrouping: { _ in [] })
        let expectation = XCTestExpectation(description: "Publishes an error")
        
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                guard case .failure(let error) = value else {
                    return XCTFail("Expected a failing Result, got: \(value) instead")
                }
                
                XCTAssertEqual(error as NSError, expectedError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}

extension MenuSection: Equatable {
    public static func == (lhs: AlbertosCore.MenuSection, rhs: AlbertosCore.MenuSection) -> Bool {
        return lhs.id == rhs.id
    }
}
