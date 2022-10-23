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

    init(id: Int, imageURL: URL?, name: String) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
    }
}

extension SuperheroViewModel: Hashable {}
