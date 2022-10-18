//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import UIKit

public class HippoPaymentsProcessor {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func processPayment(payload: [String : Any], onSuccess: @escaping () -> Void, onFailure: @escaping (HippoPaymentsError) -> Void) {
        let viewController = HippoPaymentsConfirmationViewController()
        viewController.onDismiss = onSuccess
        UIApplication.shared.currentUIWindow?.rootViewController?
            .viewControllerPresentationSource.present(viewController, animated: true, completion: .none)
    }
}

extension UIApplication {
    var currentUIWindow: UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}
