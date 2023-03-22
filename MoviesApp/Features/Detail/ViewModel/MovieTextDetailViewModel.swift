//
//  MovieTextDetailViewModel.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation

// MARK: - ViewModel

final class MovieTextDetailViewModel {
    let title: String
    let releaseYear: String
    let description: String

    init(title: String, releaseYear: String, description: String) {
        self.title = title
        self.releaseYear = releaseYear
        self.description = description
    }
}
