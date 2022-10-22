//
//  Request.swift
//  MarvelList
//
//  Created by George Davies on 22/10/2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
}

extension Request {
    private var url: URL? {
        var components = URLComponents(string: "\(baseURL)\(path)")
        components?.queryItems = parameters?.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }

    var urlRequest: URLRequest? {
        guard let url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
