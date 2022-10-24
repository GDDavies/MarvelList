//
//  SuperheroViewModel.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct SuperheroViewModel: Identifiable {
    let id: Int
    let imageURL: URL?
    let name: String
    let description: String

    init(id: Int, imageURL: URL?, name: String, description: String) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.description = description
    }
}

extension SuperheroViewModel: Hashable {}
