//
//  TestHelper.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation
@testable import FDJSport

enum TestHelper {
   static var teams: [Team] {
       [Team(id: "1",
             name: "PSG",
             shortName: "PSG",
             formedDate: "",
             alternate: "",
             league: "Ligue 1",
             stadium: "",
             badge: "https://www.thesportsdb.com/images/media/team/stadium/tvsxvw1420238927.jpg",
             logo: "",
             banner: "https://www.thesportsdb.com/images/media/team/stadium/tvsxvw1420238927.jpg",
             description: "", country: ""),
        Team(id: "2",
              name: "Olympique de marseille",
              shortName: "OM",
              formedDate: "",
              alternate: "",
              league: "Ligue 1",
              stadium: "",
              badge: "",
              logo: "",
              banner: "",
              description: "", country: "")
       ]

   }
}
