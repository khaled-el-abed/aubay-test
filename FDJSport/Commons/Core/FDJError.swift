//
//  FDJError.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation

enum FDJError: Error {
    case notFound
    case notDefined

    var title: String {
        "Error"
    }

    var descirtion: String {
        switch self {
        case .notFound:
            return "Cette élement n'existe plus."
        case .notDefined:
            return "Un Erreur est surevenu, merci de réessayer plus tard."
        }
    }
}
