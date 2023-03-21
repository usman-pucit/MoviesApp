//
//  Movies.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation

struct Movies: Decodable {
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
}

struct Movie: Decodable, Equatable {
    var uuid = UUID()
    let adult : Bool
    let backdropPath : String?
    let genreIds : [Int]
    var id : Int
    let language : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let poster : String?
    let releaseDate : String?
    let title : String
    let video : Bool
    let voteAverage : Double
    let voteCount : Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case language = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case poster = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title && lhs.originalTitle == rhs.originalTitle
    }
}
