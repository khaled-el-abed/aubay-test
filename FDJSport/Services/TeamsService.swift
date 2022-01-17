//
//  TeamsService.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation
import Alamofire
import Swinject

typealias ResultCLosure<T> = (Result<T,Error>) -> Void

protocol TeamsServiceProtocol {

    /// Get teams list
    ///
    /// - Parameters:
    ///     - ligue: The ligue to search into
    ///     - completion: Closure with Result of TeamResponse and Error
    func getTeams(by ligue: String, completion: @escaping ResultCLosure<TeamResponse>)

    /// Get the details of the team
    ///
    /// - Parameters:
    ///     - requestProvider: Provide an URLRequest  to excute
    ///     - completion: Closure with Result of TeamResponse and Error
    func getTeamDetails(for id: String, completion: @escaping ResultCLosure<TeamResponse>)
}


final class TeamsService: TeamsServiceProtocol, ApiClientProvider {

    func getTeamDetails(for id: String, completion: @escaping ResultCLosure<TeamResponse>) {
        apiClient.execute(Endpoint.team(id)) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }


    func getTeams(by ligue: String, completion: @escaping ResultCLosure<TeamResponse>) {
        apiClient.execute(Endpoint.teams(ligue)) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

// MARK: - Provider

protocol TeamServiceProvider {
    var teamService: TeamsServiceProtocol { get }
}

extension TeamServiceProvider {
    var teamService: TeamsServiceProtocol {
        Container.shared.resolve(TeamsServiceProtocol.self)!
    }
}
