//  Created on 18.10.22
//  Copyright © 2022 Flavio Serrazes. All rights reserved.

import UIKit

extension UIViewController {

    /// Travels the `presentedViewController` hierarchy backwards till it finds the top most one.
    var viewControllerPresentationSource: UIViewController {
        guard let presentedViewController = self.presentedViewController else { return self }

        return presentedViewController.viewControllerPresentationSource
    }
}
