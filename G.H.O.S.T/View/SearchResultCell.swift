//
//  SearchResultCell.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit

class SearchResultCell: UITableViewCell, UILifeCycle {
    
    /// UITableView reuse identifier
    static var identifier: String { String(describing: SearchResultCell.self) }
    
    // MARK: - Metrics
    private let contentSpacing = UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 8)
    
    // MARK: - Subviews
    lazy var avatarView = AvatarView()
    lazy var contentStackView = UIStackView()
    lazy var titleLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    lazy var metadataView = MetadataView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not needed.")
    }

    // MARK: - View Lifecycle
    
    func addSubviews() {
        contentView.addSubview(avatarView)
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(metadataView)
    }
    
    func setupSubviews() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        contentStackView.distribution = .fill
        contentStackView.alignment = .fill
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarView.topAnchor.constraint(equalTo: contentView.topAnchor).activate()
        avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).activate()
        avatarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).activate()
        
        contentStackView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: contentSpacing.left).activate()
        
        contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentSpacing.top).activate()
        contentView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: contentSpacing.right).activate()
        contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: contentSpacing.bottom).activate()
    }
    
    // MARK: - Setup
    func setup(with viewData: SearchViewData) {
        titleLabel.text = viewData.title
        
        descriptionLabel.text =  viewData.description
        
        avatarView.setup(with: viewData.avatarViewData)
        
        metadataView.setup(with: viewData.metadataViewData)
    }
}
