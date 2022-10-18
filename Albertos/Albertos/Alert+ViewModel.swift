//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import SwiftUI

extension Alert {
    struct ViewModel: Identifiable {
        let title: String
        let message: String
        let buttonText: String
        let buttonAction: (() -> Void)?
        
        var id: String { title + message + buttonText }
    }
}
