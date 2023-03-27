//
//  UILifeCycle.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit

/// Defines the life cycle of a custom UIKit class.
///
/// - Note: This protocol is valid for both UIView and UIViewController instances.
///
protocol UILifeCycle {
    
    /// Implement this function to add the subviews to their corresponding parent.
    ///
    func addSubviews()
    
    /// Sets up the state and the decoration of the subviews.
    ///
    func setupSubviews()
    
    /// Creates and activates the Auto Layout rules for the subviews.
    ///
    func setupConstraints()
    
    /// Call all the protocol methods in the correct order.
    /// 
    func initialize()
}

/// Provide the default implementation for `initialize`.
extension UILifeCycle {
    
    func initialize() {
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
}
