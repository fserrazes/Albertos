//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import AlbertosCore
@testable import Albertos

final class MenuItemDetailViewModelTests: XCTestCase {

    func test_whenItemIsInOrder_ButtonSaysRemove() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        
        let text = viewModel.addOrRemoveFromOrderButtonText
        
        XCTAssertEqual(text, "Remove from order")
    }
    
    func test_whenItemIsNotInOrder_ButtonSaysAdd() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)

        let text = viewModel.addOrRemoveFromOrderButtonText
        
        XCTAssertEqual(text, "Add to order")
    }
    
    func test_whenItemIsInOrder_ButtonActionRemovesIt() {
        
    }
    
    func test_whenItemIsNotInOrder_ButtonActionAddsIt() {
        
    }

}
