//
//  SearchViewController.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController, UILifeCycle {
    
    // MARK: - Search Controller
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Subviews
    @Autolayout
    var tableView = UITableView()
    @Autolayout
    var paginationStepperView = UIStepper()
    @Autolayout
    var paginationLabel = UILabel()
    
    // MARK: - ViewModel
    lazy var viewModel: SearchViewModelType = {
       SearchViewModel()
    }()
    
    // MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not needed.")
    }
    
    override func loadView() {
        super.loadView()
        
        /// No nib means black view.
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindReactive()
    }
    
    // MARK: - BindReactive
    private func bindReactive() {
        viewModel
            .bind(to: self)
            .forEach(disposeBag.insert)
    }
    
    // MARK: - ViewController lifecycle
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(paginationStepperView)
        view.addSubview(paginationLabel)
    }
    
    func setupSubviews() {
        navigationItem.title = "G.H.O.S.T 👻"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search for GitHub OpenSourse Things"
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no

        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        paginationStepperView.value = 1
        paginationStepperView.minimumValue = 1
        paginationStepperView.maximumValue = 1
        paginationStepperView.stepValue = 1
        
        paginationLabel.font = .boldSystemFont(ofSize: 13)
        paginationLabel.textColor = .black
    }
    
    func setupConstraints() {        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).activate()
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).activate()
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).activate()
        
        paginationStepperView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8).activate()
        paginationStepperView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).activate()
        paginationStepperView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).activate()
        
        paginationLabel.topAnchor.constraint(equalTo: paginationStepperView.topAnchor).activate()
        paginationLabel.leadingAnchor.constraint(equalTo: paginationStepperView.trailingAnchor, constant: 8).activate()
        paginationLabel.bottomAnchor.constraint(equalTo: paginationStepperView.bottomAnchor).activate()
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: paginationLabel.trailingAnchor, constant: 8).activate()

    }
}
