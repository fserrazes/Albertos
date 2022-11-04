//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import Combine
import AlbertosCore
@testable import Albertos

final class MenuListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func test_whenFetchingStarts_publishesEmptyMenu() throws {
        let (sut, _) = makeSUT()
        let sections =  try sut.sections.get()
        
        XCTAssertTrue(sections.isEmpty)
    }
    
    func test_whenFetchingMenuSucceedsAndGroupingByCategory_publishesSectionsBuiltFromReceivedMenu() {
        let menu: [MenuItem] = [
            .fixture(category: "category A", name: "item 1"),
            .fixture(category: "category B", name: "item 2"),
        ]
        
        let (sut, fetcher) = makeSUT(menuGrouping: groupMenuByCategory)
        
        let expectedMenu: [MenuSection] = [
            .fixture(category: "category B", items: [menu.last!]),
            .fixture(category: "category A", items: [menu.first!]),
        ]
        
        assertThat(sut, completesWith: .success(expectedMenu), when: {
            fetcher.complete(with: menu)
        })
    }
    
    func test_whenFetchingFails_publishesAnError() {
        let (sut, fetcher) = makeSUT()
        
        assertThat(sut, completesWith: .failure(anyNSError)) {
            fetcher.complete(with: anyNSError)
        }
    }
    
    // MARK: - Test Preview Code
    
    func test_MenuFetchingPlaceholder_ReceiveValues() {
        let viewModel =  MenuList.ViewModel(menuFetcher: MenuFetchingPlaceholder().fetchMenu())
        let expectation = XCTestExpectation(description: "Wait for loader to complete")
        
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                XCTAssertNotNil(value)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = { _ in [] },
                         file: StaticString = #filePath, line: UInt = #line) -> (MenuList.ViewModel, MenuFetcherSpy) {
        let fetcher = MenuFetcherSpy()
        let sut = MenuList.ViewModel(menuFetcher: fetcher.publisher(), menuGrouping: menuGrouping)
    
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(fetcher, file: file, line: line)
        
        return (sut, fetcher)
    }
    
    private class MenuFetcherSpy {
        var publishers = [PassthroughSubject<[MenuItem], Error>]()

        func publisher() -> AnyPublisher<[MenuItem], Error> {
            let publisher = PassthroughSubject<[MenuItem], Error>()
            publishers.append(publisher)
            return publisher.eraseToAnyPublisher()
        }

        func complete(with menuItems: [MenuItem], at index: Int = 0) {
            publishers[index].send(menuItems)
            publishers[index].send(completion: .finished)
        }

        func complete(with error: Error, at index: Int = 0) {
            publishers[index].send(completion: .failure(error))
        }
    }
    
    private func assertThat(_ sut: MenuList.ViewModel, completesWith expectedResult: Result<[MenuSection], Error>, when action: () -> Void,
                            file: StaticString = #filePath, line: UInt = #line) {
        let expectation = XCTestExpectation(description: "Wait for loader to complete")
        
        sut
            .$sections
            .dropFirst()
            .sink { receivedResult in
                switch (receivedResult, expectedResult) {
                    case let (.success(receivedMenu), .success(expectedMenu)):
                    XCTAssertEqual(receivedMenu, expectedMenu, file: file, line: line)
                        
                    case let (.failure(receivedError), .failure(expectedError)):
                    XCTAssertEqual(receivedError as NSError, expectedError as NSError, file: file, line: line)
                    
                    default:
                        XCTFail("Expected \(expectedResult), got \(receivedResult) instead.", file: file, line: line)
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)

        action()
        wait(for: [expectation], timeout: 1)
    }
}

extension MenuSection: Equatable {
    public static func == (lhs: AlbertosCore.MenuSection, rhs: AlbertosCore.MenuSection) -> Bool {
        return lhs.id == rhs.id
    }
}
