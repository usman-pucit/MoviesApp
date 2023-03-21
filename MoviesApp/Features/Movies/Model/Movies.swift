//
//  Movies.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation

struct Movies: Decodable, Equatable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
    
    static func == (lhs: Movies, rhs: Movies) -> Bool {
        lhs.page == rhs.page && lhs.totalPages == rhs.totalPages && lhs.totalResults == rhs.totalResults && lhs.results == rhs.results
    }
}

struct Movie: Decodable, Equatable {
    var id : Int
    let originalTitle : String
    let poster : String?
    let releaseDate : String?
    let title : String

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case title
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title && lhs.originalTitle == rhs.originalTitle
    }
}
