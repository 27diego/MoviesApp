//
//  MovieDetails.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct MovieDetails: Codable {
    internal init(id: Int, title: String, genres: [Genre], runtime: Int?, overview: String, popularity: Double, posterPath: String? = nil, backdropPath: String? = nil, releaseDate: String) {
        self.id = id
        self.title = title
        self.genres = genres
        self.runtime = runtime
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
    }
    
    let id: Int
    let title: String
    let genres: [Genre]
    let runtime: Int?
    let overview: String
    let popularity: Double
    var posterPath: String?
    var backdropPath: String?
    let releaseDate: String
    var formattedReleaseDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM d, yyyy"

        let date: Date? = dateFormatterGet.date(from: releaseDate)
        return dateFormatterPrint.string(from: date ?? Date())
    }
    var formattedRunTime: String? {
        if runtime != nil {
            let hours: Double = Double(runtime! / 60)
            let minutes: Double = Double(runtime! % 60)
            
            return "\(String(format: "%g", hours))hr \(String(format: "%g", minutes))"
        }
        
        return nil
    }
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
