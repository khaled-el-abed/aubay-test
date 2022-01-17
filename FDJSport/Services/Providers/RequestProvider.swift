//
//  RequestProvider.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation

protocol RequestProvider {
    var urlRequest: URLRequest { get }
}

extension Endpoint: RequestProvider {

    var urlRequest: URLRequest {
        guard  let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encodedUrl) else {
            preconditionFailure("Invalid URL used to create URL instance")
        }

        return URLRequest(url: url)
    }
}
