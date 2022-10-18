//  Created on 14.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

struct MenuRow: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        let item = menu.first!
        MenuRow(viewModel: .init(item: item))
    }
}
