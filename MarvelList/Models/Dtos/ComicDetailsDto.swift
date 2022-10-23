//
//  ComicDetailsDto.swift
//  MarvelList
//
//  Created by George Davies on 23/10/2022.
//

import Foundation

struct ComicDetailsDataDto: Decodable {
    let comicDetails: [ComicDetailsDto]

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

        self.comicDetails = try! resultsContainer.decode([ComicDetailsDto].self, forKey: .results)
    }
}

struct ComicDetailsDto: Decodable {
    let id: Int
    let title: String
    let description: String?
    let pageCount: Int
    let thumbnail: ThumbnailDto
}

extension ComicDetailsDto {
    func toDomain() -> ComicDetails {
        .init(
            id: id,
            title: title,
            description: description ?? "",
            pageCount: pageCount.description,
            imageURL: thumbnail.url
        )
    }
}
