//
//  TeamsServiceMock.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation

@testable import FDJSport


final class TeamsServiceMock: TeamsServiceProtocol {

    var shouldGetTeamsSucced: Bool = false
    var shouldGetTeamDetailsSucced: Bool = false

    var hasItems: Bool = false

    private var teams: [Team] {
        hasItems ? TestHelper.teams : []
    }


    func getTeams(by ligue: String, completion: @escaping ResultCLosure<TeamResponse>) {

        guard shouldGetTeamsSucced else {
            completion( .failure(FDJError.notFound) )
            return
        }

        completion( .success(TeamResponse(teams: teams)) )
    }


    func getTeamDetails(for id: String, completion: @escaping ResultCLosure<TeamResponse>) {
        guard shouldGetTeamDetailsSucced else {
            completion( .failure(FDJError.notFound) )
            return
        }

        completion( .success(TeamResponse(teams: teams)) )
    }
}
