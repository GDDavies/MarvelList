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

    @Published var isLoading: Bool = false
    @Published private(set) var error: ErrorViewModel?
    @Published private(set) var superheroViewModels: [SuperheroViewModel] = []
    private var comics: [Int: [Comic]] = [:]

    private let repository: RepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    convenience init() {
        self.init(repository: Repository())
    }

    func updateSuperheroes() {
        isLoading = true
        repository.getCharacters(offset: currentOffset)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case let .failure(error):
                    self.error = ErrorViewModel(title: error.localizedDescription)
                case .finished:
                    self.error = nil
                    self.currentOffset += self.limit
                }
                self.isLoading = false
            }, receiveValue: { [weak self] superheroes in
                let viewModels = superheroes.map { [weak self] in
                    self?.comics[$0.id] = $0.comics
                    return SuperheroViewModel(id: $0.id, imageURL: $0.thumbnailURL, name: $0.name)
                }
                self?.superheroViewModels.append(contentsOf: viewModels)

            })
            .store(in: &cancellables)
    }

    func shouldGetMoreSuperheroes(currentViewModel: SuperheroViewModel) -> Bool {
        currentViewModel == superheroViewModels.last
    }

    func heroViewModelForSuperhero(with viewModel: SuperheroViewModel) -> HeroViewModel {
        HeroViewModel(
            id: viewModel.id,
            imageURL: viewModel.imageURL,
            name: viewModel.name,
            repository: repository
        )
    }
}

extension ContentViewModel {
    struct ErrorViewModel {
        let title: String
    }
}
