//
//  TeamViewController.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation
import UIKit

protocol TeamsFlow {
    func navigateToTeamDetails(team: Team)
}

final class TeamsCoordinator: Coordinator {

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Private Properties

    private let navigationController: UINavigationController

    // MARK: - Public Methods

    func start() {
        let viewController = TeamsListViewController()
        let presenter = TeamsListPresenter(teamsView: viewController, with: self)

        viewController.presenter = presenter

        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - TeamsFlow

extension TeamsCoordinator: TeamsFlow {

    func navigateToTeamDetails(team: Team) {
        let detailsCoordinator = TeamDetailsCoordinator(navigationController: navigationController, team: team)
        coordinate(to: detailsCoordinator)
    }
}



