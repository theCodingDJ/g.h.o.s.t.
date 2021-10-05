//
//  SearchViewDataMapper.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

protocol ViewDataMapper {
    func mapViewData(from model: GithubRepo) -> SearchViewData?
}

class SearchViewDataMapper: ViewDataMapper {
    
    func mapViewData(from model: GithubRepo) -> SearchViewData? {
        /// If no name is provided, this repo is a no-show.
        guard let title = model.name else { return nil }
        
        return SearchViewData(
            title: title,
            description: model.description,
            avatarViewData: .init(avatarUrl: model.avatarUrl.flatMap { URL(string: $0) }),
            metadataViewData: .init(forksValue: String(format: "%d", model.forks), languageValue: model.language))
    }
}
