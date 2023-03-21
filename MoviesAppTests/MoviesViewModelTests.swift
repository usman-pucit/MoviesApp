//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Muhammad Usman on 17/03/2023.
//

@testable import MoviesApp
import Networking
import XCTest

final class MoviesViewModelTests: XCTestCase {
    // test 1.
    func testFetchMovies_withSuccess_expectMovies() async {
        // Given
        let service = NetworkServiceMock<Movies>(requestResult: .success(.mock()))
        let repository = RemoteMoviesRepositoryMock(service: service)
        let sut = await MoviesViewModel(repository: repository)

        // When
        await sut.fetchMovies()

        let movies = await sut.movies

        // Then
        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.page, 1)
        XCTAssertEqual(movies?.totalPages, 5)
        XCTAssertEqual(movies?.totalResults, 50)
        XCTAssertEqual(movies?.results.count, 2)
    }

    // test 2.
    func testFetchMovies_withError_expectErrorAlert() async {
        // Given
        let service = NetworkServiceMock<Movies>(requestResult: .failure(NetworkService.NetworkServiceError.invalidResponse))
        let repository = RemoteMoviesRepositoryMock(service: service)
        let sut = await MoviesViewModel(repository: repository)

        let expectedAlert: AlertState = .init(title: "error_title".localized, message: NetworkService.NetworkServiceError.invalidResponse.localizedDescription)

        // When
        await sut.fetchMovies()

        let movies = await sut.movies
        let alert = await sut.alert

        // Then
        XCTAssertNil(movies)
        XCTAssertEqual(alert, expectedAlert)
    }

    // test 3.
    func testFetchMoviesPaginationRequest_withSuccess_expectSuccessResults() async {
        // Given
        let service = NetworkServiceMock<Movies>(requestResult: .success(.mock(page: 1, totalPages: 3, totalResults: 9, results: [.mock()].repeated(count: 3))))
        let repository = RemoteMoviesRepositoryMock(service: service)
        let sut = await MoviesViewModel(repository: repository)

        // Request page 1
        // When
        await sut.fetchMovies(for: 1)

        let movies1 = await sut.movies
        let movieArray1 = await sut.movieArray

        // Then
        XCTAssertNotNil(movies1)
        XCTAssertTrue(movieArray1.count > 0)
        XCTAssertEqual(movieArray1.count, 3)
        XCTAssertEqual(repository.page, 1)

        // Request page 2
        // When
        await sut.getNextPageIfNecessary(movie: movieArray1.last!)

        let movies2 = await sut.movies
        let movieArray2 = await sut.movieArray

        // Then
        XCTAssertNotNil(movies2)
        XCTAssertTrue(movieArray2.count > 0)
        XCTAssertTrue(movieArray2.count == 6)
        XCTAssertEqual(repository.page, 2)

        // Request page 3
        // When
        await sut.getNextPageIfNecessary(movie: movieArray1.last!)

        let movies3 = await sut.movies
        let movieArray3 = await sut.movieArray

        // Then
        XCTAssertNotNil(movies3)
        XCTAssertTrue(movieArray3.count > 0)
        XCTAssertTrue(movieArray3.count == 9)
        XCTAssertEqual(repository.page, 3)

        // Request page 4
        // When
        await sut.getNextPageIfNecessary(movie: movieArray1.last!)

        let movies4 = await sut.movies
        let movieArray4 = await sut.movieArray

        // Then
        XCTAssertNotNil(movies4)
        XCTAssertTrue(movieArray4.count > 0)
        XCTAssertTrue(movieArray4.count == 9)
        XCTAssertEqual(repository.page, 3)
    }

    // test 4.
    func testFetchMoviesPaginationResults_withSuccess_expectMovies() async {
        // Given
        let service = NetworkServiceMock<Movies>(requestResult: .success(.mock(page: 1, totalPages: 3, totalResults: 9, results: [.mock()].repeated(count: 3))))
        let repository = RemoteMoviesRepositoryMock(service: service)
        let sut = await MoviesViewModel(repository: repository)

        // When page 1.
        await sut.fetchMovies(for: 1)
        let movieArray1 = await sut.movieArray
        let pageCount1 = repository.page

        // When page 2.
        await sut.fetchMovies(for: 2)
        let movieArray2 = await sut.movieArray
        let pageCount2 = repository.page

        // When page 3.
        await sut.fetchMovies(for: 3)
        let movieArray3 = await sut.movieArray
        let pageCount3 = repository.page

        XCTAssertEqual(pageCount1, 1)
        XCTAssertEqual(pageCount2, 2)
        XCTAssertEqual(pageCount3, 3)
        XCTAssertEqual(movieArray1.count, 3)
        XCTAssertEqual(movieArray2.count, 6)
        XCTAssertEqual(movieArray3.count, 9)
    }

    // test
    func testMoviePosterUrl_withPath_expectUrl() async {
        // Given
        let service = NetworkServiceMock<Movies>(requestResult: .success(.mock(results: [.mock(poster: "/mock.poster.url")])))
        let repository = RemoteMoviesRepositoryMock(service: service)
        let sut = await MoviesViewModel(repository: repository)

        // When
        await sut.fetchMovies()

        let movieArray = await sut.movieArray
        let movie = movieArray.first
        let posterUrl = await sut.moviePosterImageUrl(path: movie?.poster ?? "")
        let posterUrlString = posterUrl?.absoluteString ?? ""

        // Then
        XCTAssertTrue(movieArray.count > 0)
        XCTAssertNotNil(posterUrl)
        XCTAssertTrue(posterUrlString.contains("/mock.poster.url"))
        XCTAssertEqual(posterUrlString, "https://image.tmdb.org/t/p/w500/mock.poster.url")
    }
}
