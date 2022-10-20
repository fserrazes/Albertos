//  Created on 17.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct MenuItemDetail: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.name)
                .font(.title3)
                .fontWeight(.bold)

            if let spicy = viewModel.spicy {
                Text(spicy)
                    .foregroundColor(.accentColor)
            }

            Text(viewModel.price)

            Button(viewModel.addOrRemoveFromOrderButtonText) {
                viewModel.addOrRemoveFromOrder()
            }

            Spacer()
        }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct MenuItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        let item = menu.first!
        MenuItemDetail(viewModel: .init(item: item, orderController: previewOrderController))
    }
}
