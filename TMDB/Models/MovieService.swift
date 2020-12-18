//
//  MovieService.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import Foundation

protocol MovieService{}

enum MovieTypes {
    case popularMovies
    case upcomingMovies
    case topRatedMovies
    case nowPlaying
    
    var description: String {
        switch self {
        case .popularMovies:
            return "movie/popular"
        case .upcomingMovies:
            return "movie/upcoming"
        case .topRatedMovies:
            return "movie/top_rated"
        case .nowPlaying:
            return "movie/now_playing"
        }
    }
}
