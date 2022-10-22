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
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), alignment: .top)]) {
                ForEach(viewModel.superheroViewModels, id: \.name) { viewModel in
                    SuperheroView(viewModel: viewModel)
                        .onAppear {
                            if self.viewModel.shouldGetMoreSuperheroes(currentViewModel: viewModel) {
                                self.viewModel.updateSuperheroes()
                            }
                        }
                }
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
