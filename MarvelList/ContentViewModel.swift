//
//  ContentViewModel.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Combine
import Foundation

final class ContentViewModel: ObservableObject {

    private var currentOffset = 0
    private let limit = 20

    @Published var error: ErrorViewModel?
    @Published var superheroViewModels: [SuperheroViewModel] = []

    private let repository: RepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    convenience init() {
        self.init(repository: Repository())
    }

    func updateSuperheroes() {
        repository.getCharacters(offset: currentOffset)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case let .failure(error):
                    self.error = ErrorViewModel(title: error.localizedDescription)
                case .finished:
                    self.error = nil
                    self.currentOffset += self.limit
                }
            }, receiveValue: { [weak self] superheroes in
                let viewModels = superheroes.map {
                    SuperheroViewModel(imageURL: $0.thumbnailURL, name: $0.name)
                }
                self?.superheroViewModels.append(contentsOf: viewModels)

            })
            .store(in: &cancellables)
    }

    func shouldGetMoreSuperheroes(currentViewModel: SuperheroViewModel) -> Bool {
        currentViewModel == superheroViewModels.last
    }
}

extension ContentViewModel {
    struct ErrorViewModel {
        let title: String
    }
}
