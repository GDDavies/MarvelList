//
//  Repository.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Combine
import Foundation

protocol RepositoryProtocol {
    func getCharacters(offset: Int) -> AnyPublisher<[Superhero], Error>
}

final class Repository: RepositoryProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    convenience init() {
        self.init(networkService: NetworkService())
    }

    func getCharacters(offset: Int) -> AnyPublisher<[Superhero], Error> {
        networkService
            .request(with: MarvelRequest.characters(offset: offset))
            .mapError { $0 as Error }
            .map { (dto: SuperheroDataDto) -> [Superhero] in
                dto.superheroes.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }

}
