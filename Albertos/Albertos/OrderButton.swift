//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct OrderButton: View {
    @State private(set) var showingDetail: Bool = false
    let viewModel: ViewModel
    
    var body: some View {
        Button {
            self.showingDetail.toggle()
        } label: {
            Text(viewModel.text)
                .font(Font.callout.bold())
                .padding(12)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(10.0)
        }
        .sheet(isPresented: $showingDetail) {
            OrderDetail(viewModel: .init())
        }
    }
}

extension OrderButton {
    struct ViewModel {

        let text = "Your Order"
    }
}

struct OrderButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderButton(viewModel: .init())
    }
}
