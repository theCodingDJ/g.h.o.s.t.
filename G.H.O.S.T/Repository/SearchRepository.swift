//
//  SearchRepository.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol Repository {
    func getSearchResults(using input: NetworkInput) -> Observable<Result<NetworkResponse, Error>>
}

class SearchRepository: Repository {
    
    let provider = MoyaProvider<GithubApiService>()
    
    func getSearchResults(using input: NetworkInput) -> Observable<Result<NetworkResponse, Error>> {
        return provider.rx.request(GithubApiService.search(input))
            .asObservable()
            .flatMapLatest { response -> Observable<Response> in
                guard (200..<299).contains(response.statusCode) else {
                    do {
                        let errorModel = try response.map(NetworkError.self)
                        throw SearchError.fromNetworkError(error: errorModel)
                    } catch {
                        throw error
                    }
                }
                return .just(response)
            }
            .map { response -> Result<NetworkResponse, Error> in
                do {
                    return .success(try response.map(NetworkResponse.self))
                } catch let error {
                    print(error)
                    return .failure(SearchError.fromOtherError(error: error))
                }
            }
            .catch { error in
                return .just(.failure(SearchError.fromOtherError(error: error)))
            }
    }
}
