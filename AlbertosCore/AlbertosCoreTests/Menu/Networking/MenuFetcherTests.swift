//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import Combine
import AlbertosCore

protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}

extension URLSession: NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}

class MenuFetcher: MenuFetching {
    let networkFetching: NetworkFetching
    
    init(networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        let url = URL(string: "https://raw.githubusercontent.com/mokagio/tddinswift_fake_api/trunk/menu_response.json")!
        
        return networkFetching
            .load(URLRequest(url: url))
            .decode(type: [MenuItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

final class MenuFetcherTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func test_whenRequestSucceeds_publishesDecodedMenuItems() throws {
        let json = """
        [
            { "name": "a name", "category": "a category", "spicy": true, "price": 1.0 },
            { "name": "another name", "category": "a category", "spicy": true, "price": 2.0 }
        ]
        """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .success(data)))
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        
        menuFetcher
            .fetchMenu()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { items in
                    XCTAssertEqual(items.count, 2)
                    XCTAssertEqual(items.first?.name, "a name")
                    XCTAssertEqual(items.last?.name, "another name")
                    
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenRequestFails_publishesReceivedError() {
        let expectedError = URLError(.badServerResponse)
        let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .failure(expectedError)))
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        
        menuFetcher
            .fetchMenu()
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                
                XCTAssertEqual(error as? URLError, expectedError)
                expectation.fulfill()
            }, receiveValue: { items in
                XCTFail("Expected to fail, succeeded with \(items)") }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - Helpers
    
    class NetworkFetchingStub: NetworkFetching {
        private let result: Result<Data, URLError>
        
        init(returning result: Result<Data, URLError>) {
            self.result = result
        }
        
        func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
            return result.publisher
            // Use a delay to simulate the real world async behavior
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }
}
