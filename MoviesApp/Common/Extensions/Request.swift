//
//  Request.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation
import Networking

extension Request {
    // movies
    static func movies(page: Int, language: String? = nil, sortBy: String? = nil) -> Self {
        var parameters: [URLQueryItem] = [
            .init(name: "api_key", value: EnvironmentConfig.API_KEY),
            .init(name: "page", value: "\(page)")
        ]

        if let language = language, !language.isEmpty {
            parameters.append(.init(name: "language", value: language))
        }
        
        if let sortBy = sortBy, !sortBy.isEmpty {
            parameters.append(.init(name: "sort_by", value: sortBy))
        }
        
        return Request(baseURL: EnvironmentConfig.BASE_URL,
                            path: "/3/discover/movie",
                            queryItems: parameters)
    }
    
    // details
    static func details(with id: Int) -> Self {
        let parameters: [URLQueryItem] = [
            .init(name: "api_key", value: EnvironmentConfig.API_KEY)
        ]
        
        return Request(baseURL: EnvironmentConfig.BASE_URL,
                            path: "/3/movie/\(id)",
                            queryItems: parameters)
    }
}

extension Request: Equatable {
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.scheme == rhs.scheme && lhs.path == rhs.path && lhs.queryItems == rhs.queryItems && lhs.baseURL == rhs.baseURL
    }
}
