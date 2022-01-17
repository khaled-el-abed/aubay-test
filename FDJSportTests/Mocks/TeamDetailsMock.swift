//
//  TeamDetailsMock.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation

@testable import FDJSport
@testable import Swinject

final class TeamDetailsViewMock: TeamDetailsView {

    private(set) var isSetBannerCalled: Bool = false
    private(set) var isSetTitleCalled: Bool = false
    private(set) var isSetDescriptionCalled: Bool = false
    private(set) var isSetCountryCalled: Bool = false
    private(set) var isSetLeagueCalled: Bool = false
    private(set) var isLoadingDisplayed: Bool = false
    private(set) var isLoadingHided: Bool = false
    private(set) var isErrorDispalayed: Bool = false
    private(set) var isTeamFetched: Bool = false


    func setBanner(_ url: URL?) {
        isSetBannerCalled = true
    }

    func setTitle(_ value: String?) {
        isSetTitleCalled = true
    }

    func setTeamDescription(_ value: String?) {
        isSetDescriptionCalled = true
    }

    func setCountry(_ value: String?) {
        isSetCountryCalled = true
    }

    func setLeague(_ value: String?) {
        isSetLeagueCalled = true
    }

    

    init() {
//        Container.shared.register(Networking.self) { _ in NetworkingMock() }


        
//        service.getTeams(teamName: "English Premier League") { result in
//            switch result {
//            case .success(let teamResponse):
//                guard let teams = teamResponse.teams else { return }
//
//                self.teams = teams
//
//            case .failure(let error):
//                break
//            }
//        }
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
