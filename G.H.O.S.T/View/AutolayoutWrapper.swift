//
//  AutolayoutWrapper.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 27.03.23.
//

import UIKit

/// A property wrapper used to enforce the `translateAutoresizingMaskIntoConstraints = false` to the UIView objects it is applied to.
@propertyWrapper struct Autolayout<V: UIView> {
    
    public var wrappedValue: V
    
    public init(wrappedValue: V) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }
    
    func setAutoLayout() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
