//
//  SuperheroView.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import SwiftUI

struct SuperheroView: View {

    private let viewModel: SuperheroViewModel

    init(viewModel: SuperheroViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.imageURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("placeholder")
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 24))

            Text(viewModel.name)
                .multilineTextAlignment(.center)

            if viewModel.description != "" {
                Text(viewModel.description)
                    .font(.caption)
            }
        }
    }
}

struct SuperheroView_Previews: PreviewProvider {
    static var previews: some View {
        SuperheroView(
            viewModel: SuperheroViewModel(
                id: 0,
                imageURL: nil,
                name: "Spiderman",
                description: "Amazing"
            )
        )
    }
}
