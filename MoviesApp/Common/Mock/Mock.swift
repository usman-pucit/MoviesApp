//
//  Mock.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation

extension Movies {
    static func mock(page: Int = 1,
                     totalPages: Int = 5,
                     totalResults: Int = 50,
                     results: [Movie] = [.mock(), .mock()]) -> Movies
    {
        return .init(page: page,
                     totalPages: totalPages,
                     totalResults: totalResults,
                     results: results)
    }
}

extension Movie {
    static func mock(id: Int = 943_822,
                     originalTitle: String = "mock.movie.original.title",
                     poster: String? = "mock.movie.poster",
                     releaseDate: String? = "01.01.2023",
                     title: String = "mock.movie.title") -> Movie
    {
        return .init(id: id,
                     originalTitle: originalTitle,
                     poster: poster,
                     releaseDate: releaseDate,
                     title: title)
    }
}

extension Detail {
    static func mock(backdropPath: String? = "mock.backdrop.path",
                     id: Int = 1,
                     overview: String = "mock.detail.overview",
                     releaseDate: String? = "01.02.2023",
                     title: String = "mock.detail.title") -> Detail
    {
        return Detail(backdropPath: backdropPath,
                      id: id,
                      overview: overview,
                      releaseDate: releaseDate,
                      title: title)
    }
}
