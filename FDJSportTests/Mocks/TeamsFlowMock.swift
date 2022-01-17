//
//  TeamsFlowMock.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation
@testable import FDJSport

final class TeamsFlowMock: TeamsFlow {

    var isNavigationToDetailsCalled: Bool = false

    func navigateToTeamDetails(team: Team) {
        isNavigationToDetailsCalled = true
    }
}
