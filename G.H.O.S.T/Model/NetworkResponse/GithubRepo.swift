//
//  GithubRepo.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

struct GithubRepo: Decodable {
    
    let name: String?
    let htmlUrl: String?
    let description: String?
    let forks: Int
    let language: String
    let avatarUrl: String?
    
    fileprivate enum CodingKeys: String, CodingKey {
        case name
        case htmlUrl = "html_url"
        case description
        case forks
        case language
        case owner
    }
    
    fileprivate enum OwnerCodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.description = try values.decodeIfPresent(String.self, forKey: .description)
        self.forks = try values.decodeIfPresent(Int.self, forKey: .forks) ?? 0
        self.language = try values.decodeIfPresent(String.self, forKey: .language) ?? "Unspecified"
        
        let ownerValues = try values.nestedContainer(keyedBy: OwnerCodingKeys.self, forKey: .owner)
        self.avatarUrl = try ownerValues.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
}
