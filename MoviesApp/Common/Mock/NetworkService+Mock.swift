//
//  NetworkService+Mock.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation
import Networking

final class NetworkServiceMock<T: Decodable>: NetworkServiceProvider {
    public private(set) var request: Request?
    public var requestResult: Result<T, Error>?

    public init(request: Request? = nil, requestResult: Result<T, Error>? = nil) {
        self.request = request
        self.requestResult = requestResult
    }

    func execute<T>(request: Request) async throws -> T where T: Decodable {
        self.request = request

        switch requestResult {
        case let .success(value as T):
            return value
        case let .failure(error):
            throw error
        default:
            preconditionFailure("The result is invalid.")
        }
    }
}
