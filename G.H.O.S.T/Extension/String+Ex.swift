//
//  String+Ex.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
