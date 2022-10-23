//
//  ContentView.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel = ContentViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), alignment: .top)]) {
                    ForEach(viewModel.superheroViewModels, id: \.id) { superheroViewModel in
                        NavigationLink {
                            HeroView(
                                viewModel: self.viewModel.heroViewModelForSuperhero(
                                    with: superheroViewModel
                                )
                            )
                            .navigationTitle("\(superheroViewModel.name) Comics")
                        } label: {
                            SuperheroView(viewModel: superheroViewModel)
                                .onAppear {
                                    if self.viewModel.shouldGetMoreSuperheroes(currentViewModel: superheroViewModel) {
                                        self.viewModel.updateSuperheroes()
                                    }
                                }
                        }
                    }
                    .navigationTitle("Marvel Characters")
                }
                LoadingView(isLoading: $viewModel.isLoading)
            }
        }
        .padding([.leading, .trailing], 8)
        .onAppear {
            viewModel.updateSuperheroes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
