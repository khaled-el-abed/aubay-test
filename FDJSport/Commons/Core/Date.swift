//
//  Date.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation

private enum Constants {
    static let smallDateFormat = "dd/MM/YYYY"
}

extension Date {

    var smallFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.smallDateFormat
        return formatter.string(from: self )
    }
}
