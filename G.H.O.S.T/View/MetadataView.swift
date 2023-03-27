//
//  MetadataView.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit

class MetadataView: UIView, UILifeCycle {
    
    @Autolayout
    private var forkIconView = UIImageView()
    @Autolayout
    private var forkLabel = UILabel()
    @Autolayout
    private var languageIconView = UIImageView()
    @Autolayout
    private var languageLabel = UILabel()
    
    // MARK: - Metrics
    
    init() {
        super.init(frame: .zero)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not needed.")
    }
    
    func addSubviews() {
        addSubview(forkIconView)
        addSubview(forkLabel)
        addSubview(languageIconView)
        addSubview(languageLabel)
    }
    
    func setupSubviews() {
        forkIconView.image = UIImage(named: "iconFork")
        forkIconView.contentMode = .scaleAspectFit
        
        forkLabel.font = .systemFont(ofSize: 13)
        
        languageIconView.image = UIImage(named: "iconCode")
        languageIconView.contentMode = .scaleAspectFit
        
        languageLabel.font = .systemFont(ofSize: 13)
    }
    
    func setupConstraints() {
        /// Set the view's own height.
        heightAnchor.constraint(equalToConstant: 24).activate()
        
        forkIconView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).activate()
        forkIconView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).activate()
        forkIconView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).activate()
        forkIconView.widthAnchor.constraint(equalTo: forkIconView.heightAnchor, multiplier: 1).activate()
        
        forkLabel.leadingAnchor.constraint(equalTo: forkIconView.trailingAnchor, constant: 4).activate()
        
        forkLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).activate()
        forkLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).activate()
        forkLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        languageIconView.leadingAnchor.constraint(greaterThanOrEqualTo: forkIconView.trailingAnchor, constant: 16).activate()
        
        languageIconView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).activate()
        languageIconView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).activate()
        languageIconView.widthAnchor.constraint(equalTo: languageIconView.heightAnchor, multiplier: 1).activate()
        
        languageLabel.leadingAnchor.constraint(equalTo: languageIconView.trailingAnchor, constant: 4).activate()
        
        languageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).activate()
        languageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).activate()
        languageLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).activate()
        languageLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    // MARK: - Setup
    func setup(with viewData: SearchViewData.MetadataViewData?) {
        forkLabel.text = viewData?.forksValue
        
        languageLabel.text = viewData?.languageValue
    }
}
