//
//  SuperheroDataDto.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct SuperheroDataDto: Decodable {
    let superheroes: [SuperheroDto]

    enum DataKeys: String, CodingKey {
        case code
        case status
        case data
    }

    enum ResultsKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let dataContainer = try decoder.container(keyedBy: DataKeys.self)
        let resultsContainer = try dataContainer.nestedContainer(
            keyedBy: ResultsKeys.self,
            forKey: .data
        )

        self.superheroes = try resultsContainer.decode([SuperheroDto].self, forKey: .results)
    }
}
