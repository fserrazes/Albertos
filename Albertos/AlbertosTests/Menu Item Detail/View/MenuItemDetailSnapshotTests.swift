//  Created on 20.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import SwiftUI
import AlbertosCore
@testable import Albertos

final class MenuItemDetailSnapshotTests: XCTestCase {

    func test_menuItemDetail_withRegularItem() throws {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)),
               named: "IMAGE_MENU_DETAIL_WITH_ITEM_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)),
               named: "IMAGE_MENU_DETAIL_WITH_ITEM_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)),
               named: "IMAGE_MENU_DETAIL_WITH_ITEM_extraExtraExtraLarge")
    }
    
    func test_menuItemDetail_withSpicyItem() throws {
        let sut = makeSUT(withSpicyItem: true)

        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)),
               named: "IMAGE_MENU_DETAIL_WITH_SPICY_ITEM_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)),
               named: "IMAGE_MENU_DETAIL_WITH_SPICY_ITEM_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)),
               named: "IMAGE_MENU_DETAIL_WITH_SPICY_ITEM_extraExtraExtraLarge")
    }

    // MARK: - Helpers

    private func makeSUT(withSpicyItem: Bool = false) -> (UIHostingController<MenuItemDetail>) {
        let item = menu.filter {$0.spicy == withSpicyItem}.first!
        let sut = MenuItemDetail(viewModel: .init(item: item, orderController: previewOrderController))

        return UIHostingController(rootView: sut)
    }
}
