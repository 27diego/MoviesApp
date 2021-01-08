//
//  Search.swift
//  TMDB
//
//  Created by Developer on 12/26/20.
//

import Foundation

struct Search<T: Codable>: Codable {
    let results: [T]
    let totalPages: Int
}
