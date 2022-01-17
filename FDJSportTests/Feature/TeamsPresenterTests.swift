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

final class TeamPresenterTests: XCTestCase {

    private var presenter: TeamsListPresenterProtocol!
    private var teamsViewMock: TeamsViewMock!
    private var flowMock: TeamsFlowMock!

    override func setUp() {
        super.setUp()

        Container.shared.register(TeamsServiceProtocol.self) { _ in TeamsServiceMock() }

        teamsViewMock = TeamsViewMock()
        flowMock = TeamsFlowMock()

        presenter = TeamsListPresenter(teamsView: teamsViewMock,  with: flowMock)
    }

    func testFetchTeamsSuccess() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeams(by: "English Premier League")

        XCTAssertTrue(teamsViewMock.isTeamFetched)
    }

    func testFetchTeamsFail() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = false
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeams(by: "English Premier League")

        XCTAssertFalse(teamsViewMock.isTeamFetched)
    }

    func testFetchTeamsCount() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        serviceMock.hasItems = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeams(by: "English Premier League")

        XCTAssertEqual(presenter.teamsCount, 2)
    }

    func testFetchTeamsCountEmpty() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        serviceMock.hasItems = false
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.fetchTeams(by: "English Premier League")

        XCTAssertEqual(presenter.teamsCount, 0)
    }


    func testSelectTeamSuccess() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        serviceMock.hasItems = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }
        presenter.fetchTeams(by: "English Premier League")

        presenter.selectTeam(at: 0)

        XCTAssertTrue(flowMock.isNavigationToDetailsCalled)
    }

    func testSelectTeamFail() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        serviceMock.hasItems = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        presenter.selectTeam(at: 0)

        XCTAssertFalse(flowMock.isNavigationToDetailsCalled)
    }

    func testSelectGetTeamAtIndex() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        serviceMock.hasItems = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }
        presenter.fetchTeams(by: "English Premier League")

        let team = presenter.getTeam(at: 0)


        XCTAssertNotNil(team)
    }

    func testSelectGetTeamAtIndexFail() {
        let serviceMock = TeamsServiceMock()
        serviceMock.shouldGetTeamsSucced = true
        serviceMock.hasItems = true
        Container.shared.register(TeamsServiceProtocol.self) { _ in serviceMock }

        let team = presenter.getTeam(at: 0)


        XCTAssertNil(team)
    }
}
