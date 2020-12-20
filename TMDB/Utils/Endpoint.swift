//
//  Endpoint.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct Endpoint {
    var path: URLPath
    var queryItems: [URLQueryItem] = []
}

// MARK: - Adding Endpoint url
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/" + path.description
        components.queryItems = queryItems + [URLQueryItem(name: "api_key", value: "d7f7cbc08852011505702709f919057b")]
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

// MARK: - Adding publisher based url requests
extension Endpoint {
    
}


enum URLPath {
    case trending
    
    var description: String {
        return ""
    }
}
