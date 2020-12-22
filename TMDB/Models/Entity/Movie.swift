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
    
    var formattedReleaseDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM d, yyyy"

        let date: Date? = dateFormatterGet.date(from: releaseDate)
        return dateFormatterPrint.string(from: date!)
    }
}

struct MovieCreditResults: Codable {
    let id: Int
    let cast: [Actor]
    let crew: [CrewMember]
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
