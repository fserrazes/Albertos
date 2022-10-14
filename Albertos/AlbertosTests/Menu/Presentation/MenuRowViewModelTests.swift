//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

extension MenuRow {
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.name
        }
    }
}

final class MenuRowViewModelTests: XCTestCase {

    func test_whenItemIsNotSpicy_textIsItemNameOnly() {
        let item = MenuItem.fixture(name: "name", spicy: false)
        
        let viewModel = MenuRow.ViewModel(item: item)
        
        XCTAssertEqual(viewModel.text, "name")
    }
    
    func test_whenItemIsSpicy_textIsItemWithChillyEmoji() {}

}
