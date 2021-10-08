//
//  SearchViewData.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

struct SearchViewData {
    
    struct AvatarViewData {
        let avatarUrl: URL?
    }
    
    struct MetadataViewData {
        let forksValue: String
        let languageValue: String
    }
    
    let title: String
    let description: String?
    let avatarViewData: AvatarViewData?
    let metadataViewData: MetadataViewData?
    let webLink: String
}
