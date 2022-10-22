//
//  ComicsItemDto.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct ComicsItemDto: Decodable {
    let resourceURI: String
    let name: String
}

extension ComicsItemDto {
    func toDomain() -> Comic {
        .init(
            resourceURI: URL(string: resourceURI),
            name: name
        )
    }
}
