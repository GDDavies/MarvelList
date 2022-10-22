//
//  MarvelRequest.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import CryptoKit
import Foundation

enum MarvelRequest {
    case characters(offset: Int)
    case comics
}

extension MarvelRequest: Request {

    // I would not store these keys in the repo in production
    // I have put them here just for simplicity
    private struct Keys {
        static let pub = "722c1e1fe16633b8d690fd26a5cc9af9"
        static let priv = "0ac82b28462c5dcda16e1e97983f489cc07f1ccd"
    }

    var baseURL: String {
        return "https://gateway.marvel.com"
    }

    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .comics:
            return "/v1/public/characters"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .characters, .comics:
            return .get
        }
    }

    var parameters: [String: String]? {
        var parameters = defaultParameters
        switch self {
        case let .characters(offset):
            parameters["offset"] = offset.description
        case .comics:
            break
        }
        return parameters
    }

    private var defaultParameters: [String: String] {
        let timestamp =  Int(Date().timeIntervalSince1970).description
        return [
            "ts": timestamp,
            "apikey": Keys.pub,
            "hash": md5Hash(timestamp: timestamp)
        ]
    }

    private func md5Hash(timestamp: String) -> String {
        let data = Data("\(timestamp)\(Keys.priv)\(Keys.pub)".utf8)
        return Insecure.MD5
            .hash(data: data)
            .map { String(format: "%02x", $0) }
            .joined()
    }
}
