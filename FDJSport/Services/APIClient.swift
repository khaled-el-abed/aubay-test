//
//  APIClient.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation
import Swinject


final class ApiClient: Networking { }

// MARK: - Provider

protocol ApiClientProvider {

    var apiClient: Networking { get }
}

extension ApiClientProvider {

    var apiClient: Networking {
        Container.shared.resolve(Networking.self)!
    }
}
