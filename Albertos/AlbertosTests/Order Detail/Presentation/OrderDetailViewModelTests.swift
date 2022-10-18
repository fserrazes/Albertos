//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class OrderDetailViewModelTests: XCTestCase {

    func test_whenOrderIsEmpty_ShouldNotShowTotalAmount() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController())
        
        XCTAssertNil(viewModel.totalText)
    }

    func test_whenOrderIsNonEmpty_ShouldShowTotalAmount() {
        
    }

    func test_whenOrderIsEmpty_HasNotItemNamesToShow() {
        
    }

    func test_whenOrderIsNonEmpty_MenuListItemIsOrderItems() {
        
    }

}
