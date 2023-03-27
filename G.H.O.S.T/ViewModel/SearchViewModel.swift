//
//  SearchViewModel.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewModelInput: AnyObject {
    func setPage(_ value: Int)
    func setQuery(_ value: String)
}

protocol  SearchViewModelOutput {
    var paginationViewData: Driver<PaginationViewData> { get }
    var searchResults: Driver<[SearchViewData]> { get }
    var errorMessage: Driver<String> { get }
}

protocol SearchViewModelType {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput { get }
}

class SearchViewModel: SearchViewModelType {
    
    // MARK: - SearchViewModelOutput
    let paginationViewData: Driver<PaginationViewData>
    let searchResults: Driver<[SearchViewData]>
    let errorMessage: Driver<String>
    
    // MARK: - Initialization
    init(
        repository: Repository = SearchRepository(),
        mapper: ViewDataMapper = SearchViewDataMapper()
    ) {
        
        let queryObservable = queryRelay.asObservable()
            .share()
        let pageObservable = pageRelay.asObservable()
            .share()
        
        let networkInputObservable = Observable.combineLatest(
            queryObservable,
            pageObservable
        ) { NetworkInput(q: $0, page: $1) }
            .share()
        
        let request = networkInputObservable
            .flatMapLatest { repository.getSearchResults(using: $0) }
            .share()
        
        let responseSuccess = request
            .mapSuccess()
            .share()
        
        paginationViewData = responseSuccess
            .map { $0.totalCount }
            .withLatestFrom(pageObservable) { PaginationViewData(currentPage: $1, total: $0) }
            .asDriver(onErrorDriveWith: .empty())
        
        searchResults = responseSuccess
            .map { $0.items.compactMap(mapper.mapViewData) }
            .asDriver(onErrorJustReturn: [])
        
        errorMessage = request
            .mapErrorString()
            .catch { .just($0.localizedDescription) }
            .asDriver(onErrorJustReturn: "Unknown error occurred.")
    }
    
    // MARK: - SearchViewModelInput
    /// Weird, but GitHub pagination starts at 1
    /// More info: https://developer.github.com/v3/#pagination
    private let pageRelay = BehaviorRelay<Int>(value: 1)
    func setPage(_ value: Int) {
        pageRelay.accept(value)
    }
    
    private let queryRelay = PublishRelay<String>()
    func setQuery(_ value: String) {
        queryRelay.accept(value)
    }
    
    // MARK: - SearchViewModelType
    var input: SearchViewModelInput { self }
    var output: SearchViewModelOutput { self }
}

// MARK: - Input/Output declarations
extension SearchViewModel: SearchViewModelInput {}
extension SearchViewModel: SearchViewModelOutput {}
