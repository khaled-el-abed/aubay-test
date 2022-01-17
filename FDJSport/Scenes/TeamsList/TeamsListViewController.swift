//
//  TeamsViewController.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import UIKit

protocol TeamsView: AnyObject {
    func onTeamsFetched(teams: [Team])
    func onShowLoading()
    func onHideLoading()

    func onShowError(title: String, message: String, okButton: String?)

    func onShowError(_ error: FDJError)

}

private typealias Dependencies = Alertable & Loadable

final class TeamsListViewController: UIViewController, Dependencies {

    // MARK: - Constants

    private enum LocalConstants {
        static let itemHeight: CGFloat = 220
        static let itemMargin: CGFloat = 16
        static let minimumInteritemSpacing: CGFloat = 8
        static let minimumLineSpacing: CGFloat = 18
        static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let searchBarHeight: CGFloat = 20
    }

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        presenter.fetchTeams(by: "French Ligue 1")
    }

    // MARK: - Public Properties

    var presenter: TeamsListPresenterProtocol!

    // MARK: Private Properties - UI Compnents

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: view.bounds.width,
                                                  height: LocalConstants.searchBarHeight))
        return searchBar
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize =  CGSize(width: (view.bounds.width/2)-LocalConstants.itemMargin,
                                  height: LocalConstants.itemHeight)
        layout.minimumInteritemSpacing = LocalConstants.minimumInteritemSpacing
        layout.minimumLineSpacing = LocalConstants.minimumLineSpacing
        layout.sectionInset = LocalConstants.sectionInset
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    // MARK: - Private Properties

}

// MARK: - UI Setup

extension TeamsListViewController {


    private func setupUI() {
        view.backgroundColor = .white
        setupCollectionView()
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar.placeholder = "Search by league"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
    }

    private func setupCollectionView() {
        collectionView.register(TeamViewCell.self, forCellWithReuseIdentifier: TeamViewCell.identifier)
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension TeamsListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.teamsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamViewCell.identifier, for: indexPath) as? TeamViewCell,
              let presenter = presenter.getTeam(at: indexPath.row) else { return UICollectionViewCell() }
        cell.presenter = presenter

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TeamsListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectTeam(at: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate

extension TeamsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.fetchTeams(by: searchText)
    }
}

// MARK: - TeamsView

extension TeamsListViewController: TeamsView {
    func onShowError(_ error: FDJError) {
        showAlert(with: error.title, message: error.descirtion)
    }

    func onShowError(title: String, message: String, okButton: String? = nil) {
        showAlert(with: title, message: message)
    }

    func onHideLoading() {
        hideLoadingView()
    }

    func onShowLoading() {
        showLoadingView()
    }

    func onTeamsFetched(teams: [Team]) {
        collectionView.reloadData()
    }
}


