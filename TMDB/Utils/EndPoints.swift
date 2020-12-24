//
//  Endpoint.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct ItemEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    var page: Int?
}

// MARK: - Adding Endpoint url
extension ItemEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/" + path.description
        components.queryItems = queryItems + [
            URLQueryItem(name: "api_key", value: "d7f7cbc08852011505702709f919057b"),
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

// MARK: - Adding complete url paths
extension ItemEndpoint {
    static func getMovies(from type: MovieType) -> Self {
        ItemEndpoint(path: type.description)
    }
    static func getMovieDetails(for id: Int) -> Self {
        ItemEndpoint(path: "movie/\(id)")
    }
    static func getMovieCredits(for id: Int) -> Self {
        ItemEndpoint(path: "movie/\(id)/credits")
    }
    static func getPerson(for id: Int) -> Self {
        ItemEndpoint(path: "person/\(id)")
    }
    static func getPeople(from type: PersonType) -> Self {
        ItemEndpoint(path: type.description)
    }
    static func getMoviesForPerson(for id: Int) -> Self {
        ItemEndpoint(path:"person/\(id)/movie_credits")
    }
    static func getImagesForPerson(for id: Int) -> Self {
        ItemEndpoint(path: "person/\(id)/images")
    }
    static func personSearch(for query: String, page: Int = 1) -> Self {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "query", value: query), URLQueryItem(name: "page", value: String(page))]
        return ItemEndpoint(path: "search/person", queryItems: queryItems)
    }
    static func movieSearch(for query: String, page: Int = 1) -> Self {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "query", value: query), URLQueryItem(name: "page", value: String(page))]
        return ItemEndpoint(path: "search/movie", queryItems: queryItems)
    }
    static func multiSearch(for query: String, page: Int = 1) -> Self {
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "query", value: query), URLQueryItem(name: "page", value: String(page))]
        return ItemEndpoint(path: "search/multi", queryItems: queryItems)
    }
}


struct ImageEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension ImageEndpoint {
    var url: String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p/w500/" + path.description
        components.queryItems = queryItems + [URLQueryItem(name: "api_key", value: "d7f7cbc08852011505702709f919057b")]
        
        guard let url = components.string else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension ImageEndpoint {
    static func getImage(for id: String) -> Self{
        ImageEndpoint(path: "\(id)")
    }
}
