//
//  RemoteMoviesRepository.swift
//  PlandayAssessment
//
//  Created by Muhammad Usman on 04/03/2023.
//

import Foundation
import Networking

// MARK: - Type

protocol MoviesRepositoryType {
    func fetchMovies(page: Int, language: String?, sortBy: String?) async throws -> Movies
    func fetchMovieDetails(with id: Int) async throws -> Detail
}

class RemoteMoviesRepository {
    private let service: NetworkServiceProvider

    init(service: NetworkServiceProvider = NetworkService()) {
        self.service = service
    }
}

// MARK: - Extension

extension RemoteMoviesRepository: MoviesRepositoryType {
    func fetchMovies(page: Int, language: String?, sortBy: String?) async throws -> Movies {
        try await service.execute(request: .movies(page: page, language: language, sortBy: sortBy))
    }

    func fetchMovieDetails(with id: Int) async throws -> Detail {
        try await service.execute(request: .details(with: id))
    }
}
