//
//  NetworkService.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(with request: Request) -> AnyPublisher<T, NetworkServiceError>
}

enum NetworkServiceError: Error {
    case invalidURL
    case unableToDecodeData

    var localizedDescription: String {
        "Unknown Error"
    }
}

final class NetworkService: NetworkServiceProtocol {

    func request<T: Decodable>(with request: Request) -> AnyPublisher<T, NetworkServiceError> {
        guard let urlRequest = request.urlRequest else {
            return Fail(error: NetworkServiceError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in NetworkServiceError.unableToDecodeData }
            .eraseToAnyPublisher()
    }

}
