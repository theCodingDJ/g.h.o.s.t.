//
//  ObservableType+Ex.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element == Result<NetworkResponse, Error> {
    
    /// Convenience method to map the succes value from the network response
    /// - Returns: Observable of `NetworkResponse` type for later usage.
    func mapSuccess() -> Observable<NetworkResponse> {
        return flatMapLatest { value -> Observable<NetworkResponse> in
            guard case .success(let result) = value else { return .empty() }
            return .just(result)
        }
    }
    
    /// Convenience method to map the error message from the network response
    /// - Returns: Observable of `String` type for later usage.
    func mapErrorString() -> Observable<String> {
        return flatMapLatest { value -> Observable<String> in
            guard case .failure(let error) = value else { return .empty() }
            return .just(error.localizedDescription)
        }
    }
}

extension Driver where Element == PaginationViewData {
    /// Maps the view data to a pagination string.
    /// - Note: Because GitHub pagination starts at 1, the total is calculated using the formula *`((N+10)-1)/10`*
    /// - Returns: A Driver of String type that represents either `pagination` or an `empty-state` string.
    func mapToPaginationString() -> Driver<String> {
        return map { value -> String in
            guard value.total > 0 else { return "No results" }
            return "Page: \(value.currentPage) of \(((value.total + 10) - 1) / 10)"
        }
        .asDriver(onErrorJustReturn: "No results")
    }
    
    /// Maps the view data to the total pages number. Used to constraint the stepper.
    /// - Note: Because GitHub pagination starts at 1, the total is calculated using the formula *`((N+10)-1)/10`*
    /// - Returns: A Driver of String type that represents the total pages.[p
    func mapToPaginationTotalPages() -> Driver<Double> {
        return map { value -> Double in
            guard value.total > 0 else { return 1.0 }
            return Double(((value.total + 10) - 1) / 10)
        }
        .asDriver(onErrorJustReturn: 1.0)
    }
}
