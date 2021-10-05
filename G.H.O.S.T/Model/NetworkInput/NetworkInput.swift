//
//  NetworkInput.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

struct NetworkInput {
    var q: String
    var page: Int
    var per_page = 10
    
    var asParameters: [String: Any] {
        let mirror = Mirror(reflecting: self)
        return Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ label, value in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
    }
}
