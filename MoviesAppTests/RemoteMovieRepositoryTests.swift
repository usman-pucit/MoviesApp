//
//  RemoteMovieRepositoryTests.swift
//  MoviesAppTests
//
//  Created by Muhammad Usman on 22/03/2023.
//

import XCTest
import Networking
@testable import MoviesApp

final class RemoteMovieRepositoryTests: XCTestCase {
    var page: Int!
    var language: String!
    var sortBy: String!
    var request: Request!
    
    override func setUp() async throws {
        try await super.setUp()
        sortBy = ""
        language = ""
        page = 1
        request = .movies(page: page, language: language, sortBy: sortBy)
    }
    
    override func tearDown() async throws {
        sortBy = nil
        language = nil
        page = nil
        request = nil
        try await super.tearDown()
    }
    
    
    // test success
    func testFetchMovies_withSuccess_expectedResultMovies() async throws {
        // Given
        let movies = Movies.mock()
        let service = NetworkServiceMock<Movies>(requestResult: .success(.mock()))
        let sut = RemoteMoviesRepositoryMock(service: service)

        // When
        let result = try await sut.fetchMovies(page: page, language: language, sortBy: sortBy)

        // Then
        XCTAssertEqual(service.request, request)
        XCTAssertEqual(result, movies)
    }

    // test failure
    func testFetchMovies_withError_expectedResultError() async throws {
        // Given
        var currentError: Error?
        let service = NetworkServiceMock<Movies>(requestResult: .failure(URLError(.badURL)))
        let sut = RemoteMoviesRepositoryMock(service: service)

        // When

        do {
            _ = try await sut.fetchMovies(page: page, language: language, sortBy: sortBy)
        } catch {
            currentError = error
        }

        // Then
        XCTAssertEqual(service.request, request)
        XCTAssertNotNil(currentError)
        XCTAssertTrue(currentError is URLError)
    }
}
