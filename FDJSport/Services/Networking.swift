//
//  Networking.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation

protocol Networking {

    /// Excute a request
    ///
    /// - Parameters:
    ///     - requestProvider: Provide an URLRequest  to excute
    ///     - completion: Closure with Result of T and Error
    func execute<T: Decodable>(_ requestProvider: RequestProvider, completion: @escaping (Result<T, Error>) -> Void)

}

extension Networking {

    func execute<T: Decodable>(_ requestProvider: RequestProvider,
                               completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = requestProvider.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
