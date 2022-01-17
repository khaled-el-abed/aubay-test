//
//  TeamsPresenter.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation

import XCTest
@testable import FDJSport
@testable import Swinject

final class TeamDetailsPresenterTests: XCTestCase {

    private var presenter: TeamDetailsPresenterProtocol!
    private var teamDetailsViewMock: TeamDetailsViewMock!

    override func setUp() {
        super.setUp()

        Container.shared.register(TeamsServiceProtocol.self) { _ in TeamsServiceMock() }

        let fakedTeam = TestHelper.teams[0]
        teamDetailsViewMock = TeamDetailsViewMock()
        presenter = TeamDetailsPresenter(team: fakedTeam, teamDetailsView: teamDetailsViewMock)
    }

    func testFetchTeamsSuccess() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamDetailsSucced = true
        serviceMock.hasItems = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeamDetails()

        XCTAssertTrue(teamDetailsViewMock.isSetTitleCalled)
        XCTAssertTrue(teamDetailsViewMock.isSetTitleCalled)
        XCTAssertTrue(teamDetailsViewMock.isSetLeagueCalled)
        XCTAssertTrue(teamDetailsViewMock.isSetBannerCalled)
        XCTAssertTrue(teamDetailsViewMock.isSetDescriptionCalled)
    }

    func testFetchTeamsFail() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamDetailsSucced = false
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeamDetails()

        XCTAssertFalse(teamDetailsViewMock.isSetTitleCalled)
        XCTAssertFalse(teamDetailsViewMock.isSetLeagueCalled)
        XCTAssertFalse(teamDetailsViewMock.isSetBannerCalled)
        XCTAssertFalse(teamDetailsViewMock.isSetDescriptionCalled)
    }


    func testFetchBannerFail() {
        let fakedTeam = TestHelper.teams[1]
        teamDetailsViewMock = TeamDetailsViewMock()
        presenter = TeamDetailsPresenter(team: fakedTeam, teamDetailsView: teamDetailsViewMock)

        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamDetailsSucced = false
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeamDetails()

        XCTAssertFalse(teamDetailsViewMock.isSetBannerCalled)
    }
}
