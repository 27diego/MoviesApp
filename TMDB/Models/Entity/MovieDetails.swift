//
//  MovieDetails.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct MovieDetails: Codable {
    internal init(id: Int, title: String, genres: [Genre], runtime: Int?, overview: String, popularity: Double, posterPath: String? = nil, backdropPath: String? = nil) {
        self.id = id
        self.title = title
        self.genres = genres
        self.runtime = runtime
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
    
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
