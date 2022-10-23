//
//  HeroViewModel.swift
//  MarvelList
//
//  Created by George Davies on 23/10/2022.
//

import Combine
import Foundation

final class HeroViewModel: ObservableObject {

    private let id: Int
    let imageURL: URL?
    let name: String

    @Published var comicDetails: [ComicDetails] = []

    private let repository: RepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(
        id: Int,
        imageURL: URL?,
        name: String,
        repository: RepositoryProtocol
    ) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.repository = repository
    }

    func updateComicDetails() {
        repository.getComics(id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] comicDetails in
                self?.comicDetails = comicDetails
            }
            .store(in: &cancellables)
    }
}
