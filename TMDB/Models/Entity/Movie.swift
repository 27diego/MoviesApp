//
//  Movie.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let popularity: Double
    let releaseDate: String
    var backdropPath: String?
    var posterPath: String?
}
