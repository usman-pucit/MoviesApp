//
//  MovieTextDetailViewModel.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation

final class MovieTextDetailViewModel: Identifiable {
    enum TextDetailType {
        case author(String, String)
        case link(String, URL, String)
        case description(String, String)
        case source(String, String)
    }

    let id: UUID
    let type: TextDetailType

    init(id: UUID = UUID(), type: TextDetailType) {
        self.id = id
        self.type = type
    }
}
