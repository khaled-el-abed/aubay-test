//
//  TeamServiceTests.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import XCTest
@testable import FDJSport
@testable import Swinject

class TeamServiceTests: XCTestCase {

    private var service: TeamsServiceProtocol!

    override func setUp() {
        super.setUp()

        //Container.shared.register(type: Networking.self, component: NetworkingMock())

        Container.shared.register(Networking.self) { _ in NetworkingMock() }

        service =  TeamsService()
    }

    func testGetTeamsSuccess() {
        let expectation = expectation(description: "listings count equalt to 300")

        service.getTeams(by: "English Premier League") { result in


            switch result {
            case .success(let teamResponse):

                XCTAssertNotNil(teamResponse)
                XCTAssertNotNil(teamResponse.teams)
                XCTAssertFalse(teamResponse.teams?.isEmpty ?? true)

            case .failure:
                XCTFail("Can't reteive data")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testGetTeamsFail() {
        let expectation = expectation(description: "listings count equalt to 300")

        service.getTeams(by: "English Premier") { result in
            switch result {
            case .success:
                XCTFail("Data reteived when error expected ")

            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testGetTeamDetails() {
        let expectation = expectation(description: "listings count equalt to 300")

        service.getTeamDetails(for: "133604") { result in

            switch result {
            case .success(let teamResponse):

                XCTAssertNotNil(teamResponse)
                XCTAssertNotNil(teamResponse.teams)
                XCTAssertFalse(teamResponse.teams?.isEmpty ?? true)

            case .failure(let error):
                XCTFail("Can't reteive data" + error.localizedDescription)
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 15, handler: nil)
    }
}
