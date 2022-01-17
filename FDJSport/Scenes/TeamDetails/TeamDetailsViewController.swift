//
//  TeamDetailsViewController.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 16/01/2022.
//

import UIKit

protocol TeamDetailsView: AnyObject {
    func setBanner(_ url: URL?)
    func setTitle(_ value: String?)
    func setTeamDescription(_ value: String?)
    func setCountry(_ value: String?)
    func setLeague(_ value: String?)

    func onShowLoading()
    func onHideLoading()

    func onShowError(_ error: FDJError )
}

private typealias Dependencies = Alertable & Loadable

final class TeamDetailsViewController: UIViewController, Dependencies {

    // MARK: LocalConstants {

    private enum LocalConstant {
        static let containerStackViewMargin: CGFloat = 8
    }

    // MARK: - IBoutlets

    @IBOutlet weak var containerStackView: UIStackView! {
        didSet {
            containerStackView.directionalLayoutMargins.trailing = LocalConstant.containerStackViewMargin
            containerStackView.directionalLayoutMargins.leading = LocalConstant.containerStackViewMargin
            containerStackView.isLayoutMarginsRelativeArrangement = true
        }
    }

    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var ligueLabel: UILabel! {
        didSet {
            ligueLabel.font = Fonts.tilte
        }
    }

    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = Fonts.body
        }
    }

    @IBOutlet private weak var countryLabel: UILabel! {
        didSet {
            countryLabel.font = Fonts.body
        }
    }

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.fetchTeamDetails()
    }

    var presenter: TeamDetailsPresenterProtocol!
}

// MARK: - TeamDetailsView

extension TeamDetailsViewController: TeamDetailsView {

    func setTitle(_ value: String?) {
        self.title = value
    }

    func setTeamDescription(_ value: String?) {
        populateLabel(descriptionLabel, with: value)
    }

    func setCountry(_ value: String?) {
        populateLabel(countryLabel, with: value)
    }

    func setLeague(_ value: String?) {
        populateLabel(ligueLabel, with: value)
    }

    func setBanner(_ url: URL?) {
        guard let url = url else {
            bannerImageView.isHidden = true
            return
        }

        bannerImageView.kf.setImage(with: url)
    }

    func onShowError(_ error: FDJError ) {
        showAlert(with: error.title, message: error.descirtion)
    }

    func onShowLoading() {
        showLoadingView()
    }

    func onHideLoading() {
        hideLoadingView()
    }

    // MARK: - Helper

    private func populateLabel(_ label: UILabel, with value: String?) {
        guard let text = value else {
            label.isHidden = true
            return
        }

        label.text = text
    }
}
