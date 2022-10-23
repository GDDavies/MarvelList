//
//  HeroView.swift
//  MarvelList
//
//  Created by George Davies on 23/10/2022.
//

import SwiftUI

struct HeroView: View {

    @ObservedObject private var viewModel: HeroViewModel

    init(viewModel: HeroViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(
                    url: viewModel.imageURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    },
                    placeholder: { Image("placeholder") }
                )
                .frame(height: 160)
                .clipped()

                ForEach(viewModel.comicDetails, id: \.id) { viewModel in
                    ZStack {
                        Rectangle()
                            .fill(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        VStack(alignment: .leading) {
                            Text(viewModel.title)
                                .padding([.top, .bottom], 8)
                                .font(.title)
                                .fontWeight(.bold)

                            HStack {
                                AsyncImage(url: viewModel.imageURL) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100, maxHeight: 160)
                                } placeholder: {}
                            Text(viewModel.description)
                                .padding(.bottom, 8)
                                .font(.system(size: 16))
                            }

                            Text("Pages: \(viewModel.pageCount)")
                                .padding(.bottom, 8)
                                .font(.caption)
                        }
                        .padding(8)
                    }
                }
            }
            .padding([.leading, .trailing], 8)
            .onAppear {
                self.viewModel.updateComicDetails()
            }
        }
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView(
            viewModel: HeroViewModel(
                id: 0,
                imageURL: nil,
                name: "3D Man",
                repository: Repository()
            )
        )
    }
}
