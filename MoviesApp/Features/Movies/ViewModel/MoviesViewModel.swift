//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 19/03/2023.
//

import Foundation

@MainActor
final class MoviesViewModel: ObservableObject {
    // MARK: - Properties

    @Published var isLoading: Bool = false
    @Published var movieArray: [Movie] = []
    @Published var alert: AlertState?
    private(set) var movies: Movies?
    private var repository: MoviesRepositoryType
    private var pageNumber = 1

    // MARK: Public API

    init(repository: MoviesRepositoryType = RemoteMoviesRepository()) {
        self.repository = repository
    }

    func getNextPageIfNecessary(movie: Movie) async {
        if movieArray.last == movie && movies?.totalResults ?? 0 > movieArray.count {
            await fetchMovies(for: pageNumber + 1)
        }
    }

    func moviePosterImageUrl(path: String) -> URL? {
        return URL(string: EnvironmentConfig.IMAGE_URL + "w500\(path)")
    }

    func prepareMoviesList(pages: Int, movies: Movies) -> [Movie] {
        if pages > 1 {
            return movieArray + movies.results
        }
        return movies.results
    }

    func fetchMovies(for page: Int = 1) async {
        // show loader
        isLoading = true
        pageNumber = page

        do {
            let fetchedMovies = try await repository.fetchMovies(page: page, language: nil, sortBy: nil)

            // hide loader
            isLoading = false
            movies = fetchedMovies
            movieArray = prepareMoviesList(pages: page, movies: fetchedMovies)
        } catch {
            isLoading = false
            alert = .init(title: "error_title".localized, message: error.localizedDescription)
        }
    }
}
