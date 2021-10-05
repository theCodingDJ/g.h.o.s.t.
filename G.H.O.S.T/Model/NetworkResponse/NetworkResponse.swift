//
//  NetworkResponse.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

struct NetworkResponse: Decodable {
    
    let totalCount: Int
    let items: [GithubRepo]
    
    fileprivate enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount) ?? 0
        self.items = try values.decodeIfPresent([GithubRepo].self, forKey: .items) ?? []
    }
}
