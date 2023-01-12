//
//  ContentViewModelTests.swift
//  MarvelListTests
//
//  Created by George Davies on 23/10/2022.
//

import Combine
import Foundation
@testable import MarvelList
import XCTest

final class ContentViewModelTests: XCTestCase {

    private var repository: RepositoryProtocolMock!
    private var sut: ContentViewModel!

    private let timeout: TimeInterval = 2

    override func setUp() {
        super.setUp()
        repository = .init()
        sut = .init(repository: repository)
    }

    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }

    func test_isLoadingValuesAreCorrect() {
        XCTAssert(sut.isLoading ==  false)

        let subject = CurrentValueSubject<[Superhero], Error>(superheroes)
        repository.getCharactersReturnValue = subject.eraseToAnyPublisher()
        sut.updateSuperheroes()

        XCTAssert(sut.isLoading == true)

        subject.send(completion: .finished)

        let expectation = self.expectation(description: "Awaiting isLoading")

        let cancellable = sut.$isLoading.dropFirst(1).sink { isLoading in
            XCTAssert(isLoading == false)
            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout)
        cancellable.cancel()
    }

    func test_errorViewModelIsNil_whenRepositoryReturnsSuperheroArray() throws {
        repository.getCharactersReturnValue = CurrentValueSubject<[Superhero], Error>(superheroes).eraseToAnyPublisher()
        sut.updateSuperheroes()

        let expectation = self.expectation(description: "Awaiting error view model")

        let cancellable = sut.$error.sink { errorViewModel in
            XCTAssertNil(errorViewModel)
            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout)
        cancellable.cancel()
    }

    func test_superheroViewModelsAreCreated_whenRepostoryReturnsSuperheroArray() throws {
        repository.getCharactersReturnValue = CurrentValueSubject<[Superhero], Error>(superheroes).eraseToAnyPublisher()
        sut.updateSuperheroes()

        let expectation = self.expectation(description: "Awaiting superhero view models")

        let cancellable = sut.$superheroViewModels.dropFirst(1).sink { [weak self] viewModels in
            XCTAssertEqual(viewModels, self!.superheroViewModels)
            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout)
        cancellable.cancel()
    }
}

extension ContentViewModelTests {
    var superheroes: [Superhero] {
        [
            Superhero.sample(id: 0, name: "Captain Marvel"),
            Superhero.sample(id: 1, name: "Dr Strange"),
            Superhero.sample(id: 2, name: "Gambit"),
            Superhero.sample(id: 3, name: "Spiderman"),
            Superhero.sample(id: 4, name: "Wolverine")
        ]
    }

    var superheroViewModels: [SuperheroViewModel] {
        [
            SuperheroViewModel(id: 0, imageURL: nil, name: "Captain Marvel", description: "Lorem ipsum"),
            SuperheroViewModel(id: 1, imageURL: nil, name: "Dr Strange", description: "Lorem ipsum"),
            SuperheroViewModel(id: 2, imageURL: nil, name: "Gambit", description: "Lorem ipsum"),
            SuperheroViewModel(id: 3, imageURL: nil, name: "Spiderman", description: "Lorem ipsum"),
            SuperheroViewModel(id: 4, imageURL: nil, name: "Wolverine", description: "Lorem ipsum")
        ]
    }
}
