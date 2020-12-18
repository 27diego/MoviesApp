//
//  Person.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import Foundation

struct Person: Codable, Identifiable {
    var id: Int
    var name: String
    var biography: String
    var birthday: String
    private var profile_path: String
    var backDropImage: URL {
        var components = Utils.imageURL
        components.path = profile_path
        return components.url!
    }
}
