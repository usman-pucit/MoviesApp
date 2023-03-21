//
//  Detail.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation

struct Detail: Decodable {
    let adult : Bool
    let backdropPath : String?
    let genres : [Genre]
    let id : Int
    let language : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String?
    let releaseDate : String?
    let title : String
    let voteAverage : Double
    let voteCount : Int

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case id = "id"
        case language = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
