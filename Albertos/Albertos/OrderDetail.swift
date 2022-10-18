//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct OrderDetail: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(viewModel.headerText)
                .font(.title)
                .padding(.top)
            
            if viewModel.menuListItems.isEmpty {
                Text(viewModel.emptyMenuFallbackText)
                    .multilineTextAlignment(.center)
            } else {
                List(viewModel.menuListItems) { Text($0.name) }
            }
            
            if let total = viewModel.totalText {
                Text(total)
            }
            
            Spacer()
        }
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail(viewModel: .init(orderController: previewOrderController))
    }
}
