//
//  EnvironmentConfig.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 17/03/2023.
//

import Foundation

public enum EnvironmentConfig {
    // MARK: - Keys

    enum Keys {
        enum Plist {
            static let BASE_URL = "BASE_URL"
            static let API_KEY = "API_KEY"
            static let IMAGE_URL = "IMAGE_URL"
        }
    }

    // MARK: - Properties

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let BASE_URL: String = {
        guard let urlString = EnvironmentConfig.infoDictionary[Keys.Plist.BASE_URL] as? String else {
            fatalError("BASE_URL not found")
        }
        return urlString
    }()

    static let API_KEY: String = {
        guard let key = EnvironmentConfig.infoDictionary[Keys.Plist.API_KEY] as? String else {
            fatalError("TMDB_API_KEY not found")
        }
        return key
    }()

    static let IMAGE_URL: String = {
        guard let key = EnvironmentConfig.infoDictionary[Keys.Plist.IMAGE_URL] as? String else {
            fatalError("TMDB_API_KEY not found")
        }
        return key
    }()
}
