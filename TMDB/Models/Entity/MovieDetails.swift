//
//  MovieDescription.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
    var id: Int
    var title: String
    var tagline: String
    var overview: String
    var status: String
    var genres: [Genre]
    var homepage: String
    var budget: Int
    private var poster_path: String?
    var posterImage: String? {
        if let posterImg = poster_path {
            var components = Utils.imageURL
            components.path = "/t/p/w500\(posterImg)"
            return components.string!
        }
        return nil
    }
    private var backdrop_path: String?
    var backDropImage: String? {
        if let backdropImg = backdrop_path {
            var components = Utils.imageURL
            components.path = "/t/p/w500\(backdropImg)"
            return components.string!
        }
        return nil
    }
}

struct Genre: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
}

struct RecommendedMovies: Codable {
    let results: [Movie]
}
