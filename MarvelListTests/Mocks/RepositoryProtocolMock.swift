//
//  RepositoryProtocolMock.swift
//  MarvelListTests
//
//  Created by George Davies on 23/10/2022.
//

import Combine
import Foundation
@testable import MarvelList

final class RepositoryProtocolMock: RepositoryProtocol {

    var getCharactersCallCount = 0
    var getCharactersReturnValue: AnyPublisher<[Superhero], Error>!
    func getCharacters(offset: Int) -> AnyPublisher<[Superhero], Error> {
        getCharactersReturnValue
    }

    var getComicsCallCount = 0
    var getComicsReturnValue: AnyPublisher<[ComicDetails], Error>!
    func getComics(id: Int) -> AnyPublisher<[ComicDetails], Error> {
        getComicsReturnValue
    }
}
