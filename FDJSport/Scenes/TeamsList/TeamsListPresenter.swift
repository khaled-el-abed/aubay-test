//
//  TeamViewModel.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation

protocol TeamsListPresenterProtocol {
    var teamsCount: Int { get }

    func fetchTeams(by ligue: String)
    func getTeam(at index: Int) -> TeamPresenterProtocol?
    func selectTeam(at index: Int)
}

final class TeamsListPresenter: TeamsListPresenterProtocol, TeamServiceProvider  {

    // MARK: - Initalizer

    init(teamsView: TeamsView, with flow: TeamsFlow) {
        self.teamsView = teamsView
        self.coordinatorFlow = flow
    }

    // MARK: - Public Properties

    private(set) var coordinatorFlow: TeamsFlow!
    private(set) weak var teamsView: TeamsView?

    var teamsCount: Int {
        teams.count
    }

    // MARK: - Private Properties

    private var teams: [Team] = []

    // MARK: - Public Functions

    func fetchTeams(by ligue: String) {
        teamsView?.onShowLoading()
        teamService.getTeams(by: ligue) { [weak self] result in
            self?.teamsView?.onHideLoading()

            switch result {
            case .success(let teamResponse):
                let teams = teamResponse.teams ?? []
                
                self?.teams = teams
                self?.teamsView?.onTeamsFetched(teams: teams)
            case .failure(let error):
                print("🔥",error.localizedDescription)
                self?.teamsView?.onShowError(.notFound)

            }
        }
    }

    func selectTeam(at index: Int) {
        guard teams.indices.contains(index)  else { return }

        coordinatorFlow.navigateToTeamDetails(team: teams[index])
    }

    func getTeam(at index: Int) -> TeamPresenterProtocol? {
        guard teams.indices.contains(index)  else { return nil }

        return TeamPresenter(team: teams[index])
    }
}
