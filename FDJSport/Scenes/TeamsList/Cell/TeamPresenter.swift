//
//  TeamViewModel.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation


protocol TeamPresenterProtocol {
    var logoURL: URL? { get }
}

final class TeamPresenter: TeamPresenterProtocol {


    // MARK: - Initialization

    init(team: Team) {
        self.team = team
    }

    // MARK: - Public Properties

    var logoURL: URL? {
        guard let logo = team.logo else { return nil }

        return URL(string: logo)
    }

    // MARK: - Private Propetries

    private let team: Team
}
