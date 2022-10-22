//
//  Superhero.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct SuperheroDto: Decodable {
    let id: Int
    let name: String
    let thumbnail: ThumbnailDto
    let comics: ComicsDto
}

extension SuperheroDto {
    func toDomain() -> Superhero {
        .init(
            id: id,
            name: name,
            thumbnailURL: URL(string: "\(thumbnail.path).\(thumbnail.extension)"),
            comics: comics.items.map { $0.toDomain() }
        )
    }
}
