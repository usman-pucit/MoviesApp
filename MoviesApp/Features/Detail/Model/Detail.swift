//
//  Detail.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation

struct Detail: Decodable {
    let backdropPath: String?
    let id: Int
    let overview: String
    let releaseDate: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case releaseDate = "release_date"
        case title
    }
}
