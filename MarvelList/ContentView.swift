//
//  ContentView.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import SwiftUI

import Combine // for now

struct ContentView: View {

    @ObservedObject private var viewModel = ContentViewModel()

    var body: some View {
        Text("Hello, world!")
            .padding()
            .task {
                viewModel.test()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class ContentViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    init() {

    }

    func test() {
        NetworkService()
            .request(with: MarvelRequest.characters)
            .sink(receiveCompletion: { (error: Subscribers.Completion<NetworkServiceError>) in
                print(error)
            }, receiveValue: { (superheroes: SuperheroDataDto) in
                let test = superheroes.superheroes.map { $0.toDomain() }
                dump(test)
            })
            .store(in: &cancellables)
    }

}
