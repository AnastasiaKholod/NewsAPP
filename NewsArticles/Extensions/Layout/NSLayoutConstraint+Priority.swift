//
//  NSLayoutConstraint.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/13/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    /// Returns the constraint sender with the passed priority.
    ///
    /// - Parameter priority: The priority to be set.
    /// - Returns: The sended constraint adjusted with the new priority.
    @discardableResult
    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}

extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 1)
    }
}
