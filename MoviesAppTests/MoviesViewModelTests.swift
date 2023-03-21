//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Muhammad Usman on 17/03/2023.
//

import XCTest
import Networking
@testable import MoviesApp

final class MoviesViewModelTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
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
    func testFetchMoviesPaginationRequest_withSuccess_expectSuccessResults() {
        
    }
    
    // test 4.
    func testFetchMoviesPaginationResults_withSuccess_expectMovies() {
        
    }
}
