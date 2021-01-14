//
//  Movie.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

protocol Movie {
    var id: Int { get }
    var title: String { get }
    var popularity: Double { get }
    var releaseDate: String? { get }
    var backdropPath: String? { get set }
    var posterPath: String? { get set }
    var overview: String { get set }
}

struct MovieModel: Codable, Identifiable, Movie {
    internal init(id: Int, title: String, popularity: Double, releaseDate: String?, backdropPath: String? = nil, posterPath: String? = nil, overview: String) {
        self.id = id
        self.title = title
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.overview = overview
    }
    
    let id: Int
    let title: String
    let popularity: Double
    let releaseDate: String?
    var backdropPath: String?
    var posterPath: String?
    var overview: String
    
    var formattedReleaseDate: String {
        if let release = releaseDate{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMMM d, yyyy"

            let date: Date? = dateFormatterGet.date(from: release)
            return dateFormatterPrint.string(from: date!)
        }
        return ""
    }
}

struct MovieCreditResults: Codable {
    let id: Int
    let cast: [Actor]
    let crew: [CrewMember]
}


enum MovieType: String {
    case popular = "movie/popular"
    case upcoming = "movie/upcoming"
    case topRated = "movie/top_rated"
    case nowPlaying = "movie/now_playing"
    
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
