//
//  TeamDetailsCoordinator.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation
import UIKit

final class TeamDetailsCoordinator: Coordinator {

    // MARK: - Initialization

    init(navigationController: UINavigationController, team: Team) {
        self.team = team
        self.navigationController = navigationController
    }

    // MARK: - Private Properties

    private let navigationController: UINavigationController
    private let team: Team
    
    // MARK: - Public Methods

    func start() {
        let viewController =  TeamDetailsViewController(nibName: "TeamDetailsViewController", bundle: nil)
        let presenter = TeamDetailsPresenter(team: team, teamDetailsView: viewController)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: true)
    }
}
