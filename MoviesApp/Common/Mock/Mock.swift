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
                     results: [Movie] = [.mock()]) -> Movies {
        
        return .init(page: page,
                     totalPages: totalPages,
                     totalResults: totalResults,
                     results: results)
    }
}

extension Movie {
    static func mock(id: Int = 1,
                     originalTitle: String = "title",
                     poster: String? = "",
                     releaseDate: String? = "",
                     title: String = "title") -> Movie {
        
        return .init(id: id,
                     originalTitle: originalTitle,
                     poster: poster,
                     releaseDate: releaseDate,
                     title: title)
    }
}

extension Detail {
    static func mock(backdropPath: String? = "",
                     id: Int = 1,
                     overview: String = "",
                     releaseDate: String? = "",
                     title: String = "") -> Detail {
        
        return Detail(backdropPath: backdropPath,
                      id: id,
                      overview: overview,
                      releaseDate: releaseDate,
                      title: title)
    }
}
