//
//  SearchViewController+Binding.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

extension SearchViewModelInput {
    func bind(to viewController: SearchViewController) -> [Disposable] {
        return [
            viewController.searchController.searchBar.rx.text.orEmpty
                .filter { !$0.isEmpty } /// Ignore if string is empty.
                .debounce(.milliseconds(666), scheduler: MainScheduler.instance) /// Wait 666 milliseconds before setting the value.
                .subscribe(onNext: { [weak self] value in
                    // Reset the current page
                    self?.setPage(1)
                    
                    self?.setQuery(value)
                }),
            viewController.paginationStepperView.rx.value
                .debounce(.milliseconds(666), scheduler: MainScheduler.instance) /// Wait 666 milliseconds before setting the value.
                .subscribe(onNext: { [weak self] value in
                    self?.setPage(Int(value))
                }),
            viewController.tableView.rx.modelSelected(SearchViewData.self)
                .map { $0.webLink }
                .compactMap { URL(string: $0) }
                .map { SFSafariViewController(url: $0) }
                .subscribe(onNext: { safariViewController in
                    safariViewController.modalPresentationStyle = .overCurrentContext
                    viewController.navigationController?.present(safariViewController, animated: true)
                })
        ]
    }
}

extension SearchViewModelOutput {
    func bind(to viewController: SearchViewController) -> [Disposable] {
        return [
            paginationViewData
                .mapToPaginationString()
                .drive(viewController.paginationLabel.rx.text),
            paginationViewData
                .mapToPaginationTotalPages()
                .drive(viewController.paginationStepperView.rx.maximumValue),
            searchResults
                .drive(viewController.tableView.rx
                        .items(cellIdentifier: SearchResultCell.identifier, cellType: SearchResultCell.self)) { (_, viewData, cell) in
                            cell.setup(with: viewData)
                },
            errorMessage
                .drive(onNext: { value in
                    let alertController = UIAlertController(title: "Error", message: value, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
                    viewController.present(alertController, animated: true, completion: nil)
                })
        ]
    }
}

extension SearchViewModelType {
    func bind(to viewController: SearchViewController) -> [Disposable] {
        return [
            input.bind(to: viewController),
            output.bind(to: viewController),
        ].flatMap { $0 }
    }
}
