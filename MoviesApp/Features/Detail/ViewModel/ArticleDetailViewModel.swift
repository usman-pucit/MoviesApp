//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation

// MARK: - ViewModel

class MovieDetailViewModel: ObservableObject {
    // MARK: - Properties

    var movieTexts: [MovieTextDetailViewModel] = []
    let movie: Movie

    // MARK: - Public API

    init(movie: Movie) {
        self.movie = movie
        movieTexts = makeMovieTextsViewModel()
    }

    private func makeMovieTextsViewModel() -> [MovieTextDetailViewModel] {
        var movieTexts: [MovieTextDetailViewModel] = []

        if !movie.originalTitle.isEmpty {
            movieTexts.append(.init(type: .description("info", movie.originalTitle)))
        }

        if !movie.title.isEmpty {
            movieTexts.append(.init(type: .author("info", movie.title)))
        }
        
        return movieTexts
    }
}
