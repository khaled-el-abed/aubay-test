//
//  Team.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation

struct Team: Codable {

    let id: String?
    let name: String?
    let shortName: String?
    let formedDate: String?
    let alternate: String?
    let league: String?
    let stadium: String?
    let badge: String?
    let logo: String?
    let banner: String?
    let description: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case name = "strTeam"
        case shortName = "strTeamShort"
        case formedDate = "intFormedYear"
        case alternate = "strAlternate"
        case league = "strLeague"
        case stadium = "strStadium"
        case badge = "strTeamBadge"
        case logo = "strTeamLogo"
        case banner = "strTeamBanner"
        case description = "strDescriptionEN"
        case country = "strCountry"
    }
}
