//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct OrderDetail: View {
    @ObservedObject private(set) var viewModel: ViewModel

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
            
            //TODO: Checkout buttom and OrderButton has the same style
            if viewModel.shouldShowCheckoutButton {
                Button {
                    viewModel.checkout()
                } label: {
                    Text(viewModel.checkoutButtonText)
                        .font(Font.callout.bold())
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10.0)
                }
            }
            
            Spacer()
        }
        .padding(10)
        .alert(item: $viewModel.alertToShow) { alertViewModel in
            Alert(title: Text(alertViewModel.title), message: Text(alertViewModel.message),
                  dismissButton: .default(Text(alertViewModel.buttonText), action: alertViewModel.buttonAction)
            )
        }
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetail(viewModel: .init(orderController: previewOrderController, paymentProcessor: previewPaymentProcessor, onAlertDismiss: {}))
    }
}
