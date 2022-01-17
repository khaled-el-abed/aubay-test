//
//  NetworkingMock.swift
//  FDJSportTests
//
//  Created by Khaled ElAbed perso on 15/01/2022.
//

import Foundation

@testable import FDJSport

private enum Constants {
    static let urlSeparator = "/"
    static let extensionSeparator = "."
}

class NetworkingMock: Networking {

    func execute<T: Decodable>(_ requestProvider: RequestProvider, completion: @escaping (_ result: Result<T, Error>) -> Void) {
        guard let  url = requestProvider.urlRequest.url,
              let fileName = url.absoluteString.components(separatedBy: Constants.urlSeparator).last,
                var file = fileName.components(separatedBy: Constants.extensionSeparator).first
                 else {

            return
        }



        if let comp = requestProvider.urlRequest.url?.components,
           let queries = comp.queryItems {
            let utrString = queries.reduce("") { text, query in "\(text)_\(query.name)_\(query.value!)"}.replacingOccurrences(of: " ", with: "_")

            file = file + utrString
        }

        guard let result = getJson(from: file) else {
            completion(.failure(FDJError.notFound))
            return
        }

        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: result)

            completion(.success(decodedObject))
        } catch  {
            completion(.failure(error))
        }
    }

    private  func getJson(from file: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        print("🔥", #function, file)
        guard let path = bundle.path(forResource: file, ofType: ".json") else {
            return nil
        }

        do {
            let fileURL = URL(fileURLWithPath: path)
            return try Data(contentsOf: fileURL)
        } catch {

        }

        return nil
    }
}

extension URL {
    var components: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}

extension Array where Iterator.Element == URLQueryItem {
    subscript(_ key: String) -> String? {
        return first(where: { $0.name == key })?.value
    }
}
