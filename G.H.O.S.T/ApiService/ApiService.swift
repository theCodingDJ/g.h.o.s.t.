//
//  ApiService.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation
import Moya

@frozen enum GithubApiService {
    case search(NetworkInput)
    // TODO: Add more endpoints.
}

extension GithubApiService: TargetType {
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .search(_):
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .search(let inputModel):
            return .requestParameters(parameters: inputModel.asParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        ["Accept": "application/vnd.github.v3+json"]
    }
}
