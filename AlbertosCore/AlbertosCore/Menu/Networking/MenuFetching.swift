//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import Combine
import Foundation

public protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}

public class MenuFetcher: MenuFetching {

    let networkFetching: NetworkFetching

    public init(networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
    }

    public func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        return networkFetching.load(URLRequest(url: URL(string: "https://s3.amazonaws.com/mokacoding/menu_response.json")!))
            .decode(type: [MenuItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
