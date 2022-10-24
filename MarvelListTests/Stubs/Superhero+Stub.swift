//
//  Superhero+Stub.swift
//  MarvelListTests
//
//  Created by George Davies on 23/10/2022.
//

import Foundation
@testable import MarvelList

extension Superhero {
    static func sample(id: Int, name: String) -> Superhero {
        Superhero(
            id: id,
            name: name,
            thumbnailURL: nil,
            comics: [
                Comic.sample(name: "Comic One"),
                Comic.sample(name: "Comic Two"),
                Comic.sample(name: "Comic Three")
            ]
        )
    }
}
