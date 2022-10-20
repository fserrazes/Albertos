//  Created on 20.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import XCTest
import SwiftUI
import Combine
import AlbertosCore
@testable import Albertos

final class MenuListSnapshotTests: XCTestCase {
    
    func test_menuList_withItems() throws {
        let (sut, loader) = makeSUT()

        loader.send(menu)

        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)),
               named: "IMAGE_MENU_LIST_WITH_ITEMS_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)),
               named: "IMAGE_MENU_LIST_WITH_ITEMS_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)),
               named: "IMAGE_MENU_LIST_WITH_ITEMS_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers

    private func makeSUT() -> (UIHostingController<MenuList>, PassthroughSubject<[MenuItem], Error>) {
        let publisher = PassthroughSubject<[MenuItem], Error>()
        let viewModel = MenuList.ViewModel(menuFetcher: publisher.eraseToAnyPublisher())

        let sut = MenuList(viewModel: viewModel, orderController: previewOrderController)
        return (UIHostingController(rootView: sut), publisher)
    }
}
