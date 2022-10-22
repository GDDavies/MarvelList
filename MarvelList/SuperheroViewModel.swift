//
//  SuperheroViewModel.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct SuperheroViewModel: Equatable {
    let imageURL: URL?
    let name: String

    init(imageURL: URL?, name: String) {
        if let imageURL, var components = URLComponents(url: imageURL, resolvingAgainstBaseURL: false) {
            components.scheme = "https"
            self.imageURL = components.url
        } else {
            self.imageURL = nil
        }
        self.name = name
    }
}
