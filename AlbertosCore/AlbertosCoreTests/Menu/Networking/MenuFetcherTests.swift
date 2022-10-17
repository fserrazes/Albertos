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

    func test_whenRequestSucceeds_publishesDecodedMenuItems() {
        
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
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }
    
}
