//
//  Comic.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct ComicsDto: Decodable {
    let items: [ComicsItemDto]
}
