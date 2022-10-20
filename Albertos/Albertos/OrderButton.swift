//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI
import AlbertosCore

struct OrderButton: View {
    @EnvironmentObject var paymentProcessor: PaymentProcessingProxy
    
    @State private(set) var showingDetail: Bool = false
    
    let viewModel: ViewModel
    
    var body: some View {
        Button {
            self.showingDetail.toggle()
        } label: {
            Text(viewModel.text)
        }
        .buttonStyle(AlbertosButtonStyle())
        .sheet(isPresented: $showingDetail) {
            OrderDetail(viewModel: .init(orderController: viewModel.orderController,
                                         paymentProcessor: paymentProcessor,
                                         onAlertDismiss: { self.showingDetail = false }))
        }
    }
}

struct OrderButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderButton(viewModel: .init(orderController: previewOrderController))
            .environmentObject(PaymentProcessingProxy())
    }
}

