//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation

// MARK: - ViewModel

@MainActor
final class MovieDetailViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var isLoading: Bool = false
    @Published var alert: AlertState?
    @Published var detail: Detail?
    @Published var backdropUrl: URL?
    @Published var textDetail: MovieTextDetailViewModel = .init(title: "", releaseYear: "", description: "")
    
    private var movieId: Int
    private var repository: MoviesRepositoryType
    
    // MARK: - Public API

    init(movieId: Int, repository: MoviesRepositoryType = MoviesRepository()) {
        self.movieId = movieId
        self.repository = repository
    }
    
    func movieBackdropImageUrl(with path: String) -> URL? {
        return URL(string: EnvironmentConfig.IMAGE_URL+"w500\(path)")
    }
    
    func fetchMovieDetails() async {
        isLoading = true
        
        do {
            let fetchedDetail = try await repository.fetchMovieDetails(with: movieId)
            
            isLoading = false
            detail = fetchedDetail
            backdropUrl = movieBackdropImageUrl(with: detail?.backdropPath ?? "")
            textDetail = makeMovieTextDetailViewModel(with: fetchedDetail)
        } catch {
            isLoading = false
            alert = .init(title: "error_title".localized, message: error.localizedDescription)
        }
    }
    
    private func makeMovieTextDetailViewModel(with detail: Detail) -> MovieTextDetailViewModel {
        return .init(title: detail.title, releaseYear: detail.releaseDate?.formattedDate(formate: .yyyy) ?? "", description: detail.overview)
    }
}
