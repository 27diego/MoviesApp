//
//  MovieDetails.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let genres: [Genre]
    let runtime: Int?
    let overview: String
    let popularity: Double
    var posterPath: String?
    var backdropPath: String?
    
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
