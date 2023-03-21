//
//  Array.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 21/03/2023.
//

import Foundation

extension Array {
    func repeated(count: Int) -> Array<Element> {
        assert(count > 0, "count must be greater than 0")
        var result = self
        for _ in 0 ..< count - 1 {
            result += self
        }
        return result
    }
}
