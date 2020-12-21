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


enum MovieType {
    case popular, upcoming, topRated, nowPlaying
    
    var description: String {
        switch self{
        case .popular:
            return "movie/popular"
        case .upcoming:
            return "movie/upcoming"
        case .topRated:
            return "movie/top_rated"
        case .nowPlaying:
            return "movie/now_playing"
        }
    }
}
