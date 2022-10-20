//  Created on 19.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct AlbertosButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.callout.bold())
            .padding(12)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10.0)
    }
}
