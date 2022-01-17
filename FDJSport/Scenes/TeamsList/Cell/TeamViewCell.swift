//
//  TeamViewCell.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import UIKit
import Kingfisher


final class TeamViewCell: UICollectionViewCell {

    // MARK: - Statics

    static let identifier = String(describing: TeamViewCell.self)

    // MARK: - UI Components

    private lazy var listingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func prepareForReuse() {
        listingImageView.image = nil
    }

    // MARK: - Public Properties

    var presenter: TeamPresenterProtocol! {
        didSet {
            setLogo()
        }
    }
}

extension TeamViewCell {

    private func setLogo() {
        guard let logoUrl = presenter.logoURL else { return }

        listingImageView.kf.setImage(with: logoUrl)
    }
}


// MARK: - Setup UI

extension TeamViewCell {

    // MARK: - Private Methods

    private func setupUI() {
        contentView.backgroundColor = .white

        setupImageView()
    }

    private func setupImageView() {
        contentView.addSubview(listingImageView)

        listingImageView.contentMode = .scaleAspectFit
        listingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: listingImageView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: listingImageView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: listingImageView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: listingImageView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: -2).isActive = true
    }
}
