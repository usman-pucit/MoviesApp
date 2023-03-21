//
//  Mock.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation

extension Movie {
    static func mock(adult: Bool = false,
                     backdropPath: String? = "",
                     genreIds: [Int] = [],
                     id: Int = 1,
                     language: String = "en",
                     originalTitle: String = "title",
                     overview: String = "overview",
                     popularity: Double = 1,
                     poster: String? = "",
                     releaseDate: String? = "",
                     title: String = "title",
                     video: Bool = false,
                     voteAverage: Double = 1,
                     voteCount: Int = 1) -> Movie {
        
        return .init(adult: adult,
                     backdropPath: backdropPath,
                     genreIds: genreIds,
                     id: id,
                     language: language,
                     originalTitle: originalTitle,
                     overview: overview,
                     popularity: popularity,
                     poster: poster,
                     releaseDate: releaseDate,
                     title: title,
                     video: video,
                     voteAverage: voteAverage,
                     voteCount: voteCount)
    }
}
