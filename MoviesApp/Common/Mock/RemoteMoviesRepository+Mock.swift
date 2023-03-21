//
//  RemoteMoviesRepository+Mock.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation
import Networking

final class RemoteMoviesRepositoryMock: MoviesRepositoryType {
    private(set) var page = 0
    private(set) var language: String?
    private(set) var sortBy: String?
    private(set) var movieId = 0
    private let service: NetworkServiceProvider
    
    init(service: NetworkServiceProvider = NetworkServiceMock<Movies>(request: .movies(page: 1))) {
        self.service = service
    }
    
    func fetchMovies(page: Int, language: String?, sortBy: String?) async throws -> Movies {
        self.page = page
        self.language = language
        self.sortBy = sortBy
        let request = Request.movies(page: page, language: language, sortBy: sortBy)
        
        return try await service.execute(request: request)
    }
    
    func fetchMovieDetails(with id: Int) async throws -> Detail {
        self.movieId = id
        let request = Request.details(with: id)
        
        return try await service.execute(request: request)
    }
}
