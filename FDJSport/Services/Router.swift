//
//  Router.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation

enum Router {

   enum path {
        static let teams = "/search_all_teams.php"
        static let team = "/lookupteam.php"
    }

    private enum Constants {
        static let authrizationKey: String = "40130162"
    }

    static var baseUrl: String {
        "https://www.thesportsdb.com/api/v1/json/\(Constants.authrizationKey)"
    }
}

enum Endpoint {
    case teams(String)
    case team(String)

    var urlString: String {
        switch self {
        case .teams(let ligue):
            return "\(Router.baseUrl)\(Router.path.teams)?l=\(ligue)"
        case .team(let id):
            return "\(Router.baseUrl)\(Router.path.team)?id=\(id)"
        }
    }
}


