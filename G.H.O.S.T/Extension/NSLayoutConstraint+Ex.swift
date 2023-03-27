//
//  NSLayoutConstraint+Ex.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit

extension NSLayoutConstraint {
    
    /// Activates the layout constraint.
    ///
    /// - Returns: This constraint to allow chaining.
    @discardableResult
    public func activate() -> Self {
        isActive = true
        return self
    }
}
