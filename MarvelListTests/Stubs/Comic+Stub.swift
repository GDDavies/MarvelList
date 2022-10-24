//
//  Comic+Stub.swift
//  MarvelListTests
//
//  Created by George Davies on 23/10/2022.
//

import Foundation
@testable import MarvelList

extension Comic {
    static func sample(name: String) -> Comic {
        Comic(
            resourceURI: nil,
            name: name
        )
    }
}
