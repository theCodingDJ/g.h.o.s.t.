//
//  NetworkError.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation

struct NetworkError: Decodable {
    let message: String?
}

// MARK: - Error enum
// FIXME: - Move it to a separate file?
enum SearchError: Swift.Error {
    case fromNetworkError(error: NetworkError)
    case fromOtherError(error: Error)
    // TODO: - Add more errors if necessary.
}

extension SearchError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fromNetworkError(let error):
            return error.message ?? "Unknown error occurred."
        case .fromOtherError(let error):
            return error.localizedDescription
        }
    }
}

extension SearchError: CustomNSError {
    public var errorUserInfo: [String: Any] {
        var userInfo: [String: Any] = [:]
        userInfo[NSLocalizedDescriptionKey] = errorDescription
        userInfo[NSUnderlyingErrorKey] = errorDescription
        return userInfo
    }
}
