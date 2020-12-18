//
//  Utils.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import Foundation

struct Utils {
    static var URLcomponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "d7f7cbc08852011505702709f919057b"),
            URLQueryItem(name: "language", value: "en-US")
        ]
        return components
    }
    
    static var imageURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        return components
    }
}
