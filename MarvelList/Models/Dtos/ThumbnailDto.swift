//
//  ThumbnailDto.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

struct ThumbnailDto: Decodable {
    let path: String
    let `extension`: String
}

extension ThumbnailDto {
    var url: URL? {
        let url = URL(string: "\(path).\(`extension`)")
        if let url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.scheme = "https"
            return components.url
        } else {
            return url
        }
    }
}
