//
//  Movie.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import Foundation

struct MovieResults: Codable {
    var results: [Movie]
}

struct Movie: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var popularity: Double
    private var poster_path: String?
    private var backdrop_path: String?
    var watched: Bool? = false
    var watchProgress: Int? = 0
    var backDropImage: String? {
        if let backdropimg = backdrop_path {
            var components = Utils.imageURL
            components.path = "/t/p/w500\(backdropimg)"
            return components.string!
        }
        return nil
    }
    var posterImage: String? {
        if let posterImg = poster_path {
            var components = Utils.imageURL
            components.path = "/t/p/w500\(posterImg)"
            return components.string!
        }
        
        return nil
    }
}
