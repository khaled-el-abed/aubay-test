//
//  TeamDetailsViewModel.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 16/01/2022.
//

import Foundation

protocol TeamDetailsPresenterProtocol {
    func onStart()
    func fetchTeamDetails()
}

final class TeamDetailsPresenter: TeamDetailsPresenterProtocol, TeamServiceProvider {

    // MARK: - Initialization

    init(team: Team, teamDetailsView: TeamDetailsView) {
        self.team = team
        self.teamDetailsView = teamDetailsView
    }

    // MARK: - Public Properties

    private(set) weak var teamDetailsView: TeamDetailsView?

    var banner: URL? {
        guard let banner = team.banner else { return nil }

        return URL(string: banner)
    }

    // MARK: - Private Properties

    private var team: Team!

    // MARK: - Public Functions

    func onStart() {
        processResult(with: team)
    }

    func fetchTeamDetails() {

        teamDetailsView?.onShowLoading()

        guard let id = team.id else { return }

        teamService.getTeamDetails(for: id) { [weak self] result in
            guard let self = self else { return }

            self.teamDetailsView?.onHideLoading()
            switch result {
            case .success(let teamResponse):
                guard let team = teamResponse.teams?.first else {

                    self.teamDetailsView?.onShowError(.notFound)
                    return
                }

                self.processResult(with: team)
            case .failure:
                self.teamDetailsView?.onShowError(.notDefined)
            }
        }
    }

    // MARK: - Private Functions

    private func processResult(with team: Team) {

        self.team = team
        teamDetailsView?.setLeague(team.league)
        teamDetailsView?.setCountry(team.country)
        teamDetailsView?.setTeamDescription(team.description)
        teamDetailsView?.setLeague(team.league)
        teamDetailsView?.setTitle(team.name)
        teamDetailsView?.setBanner(banner)
    }
}
