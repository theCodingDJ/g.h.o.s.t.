//
//  AvatarView.swift
//  G.H.O.S.T
//
//  Created by Lyubomir Marinov on 5.10.21.
//

import UIKit
import Kingfisher

class AvatarView: UIView, UILifeCycle {
    
    // MARK: - Metrics
    private let avatarWidth: CGFloat = 64
    private let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    lazy public var imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not needed.")
    }
    
    // MARK: - View Lifecycle
    func addSubviews() {
        addSubview(imageView)
    }
    
    func setupSubviews() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = avatarWidth / 2
        imageView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding.top).activate()
        imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding.left).activate()
        safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding.right).activate()
        safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: padding.bottom).activate()
        imageView.widthAnchor.constraint(equalToConstant: avatarWidth).activate()
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).activate()
    }
    
    // MARK: - Setup
    func setup(with viewData: SearchViewData.AvatarViewData?) {
        ///  Get the application icon as a fallback image.
        let fallbackImage = Bundle.main.infoDictionary
            .flatMap { $0["CFBundleIcons"] as? [String: Any] }
            .flatMap { $0["CFBundlePrimaryIcon"] as? [String: Any] }
            .flatMap { $0["CFBundleIconFiles"] as? [String] }
            .flatMap { $0.last }
            .flatMap { UIImage(named: $0) }
        
        imageView.kf.setImage(with: viewData?.avatarUrl, placeholder: fallbackImage)
    }
}
