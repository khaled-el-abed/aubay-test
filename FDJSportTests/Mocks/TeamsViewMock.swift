//
//  TeamsViewMock.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation
@testable import FDJSport
@testable import Swinject

final class TeamsViewMock: TeamsView {

    private(set) var isTeamFetched: Bool = false
    private(set) var isLoadingDisplayed: Bool = false
    private(set) var isLoadingHided: Bool = false
    private(set) var isErrorDispalayed: Bool = false

    
    func onTeamsFetched(teams: [Team]) {
        isTeamFetched = true
    }

    func onShowLoading() {
        isLoadingDisplayed = true
    }

    func onHideLoading() {
        isLoadingDisplayed = true
    }

    func onShowError(title: String, message: String, okButton: String?) {
        isErrorDispalayed = true
    }

    func onShowError(_ error: FDJError) {
        isErrorDispalayed = true
    }
}
