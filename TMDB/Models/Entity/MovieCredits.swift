//
//  MovieCredits.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import Foundation

struct MovieCredits: Codable {
    var id: Int
    var cast: [Cast]
    var crew: [Crew]
}

struct Cast: Codable, Identifiable {
    var id: Int
    var name: String
    var popularity: Double
    private var profile_path: String?
    var character: String
    var order: Int
    var profileImage: String? {
        if let profilePicture = profile_path {
            var components = Utils.imageURL
            components.path = "/t/p/w500\(profilePicture)"
            return components.string!
        }
        return nil
    }
}

struct Crew: Codable, Identifiable {
    var id: Int
    var name: String
    var popularity: Double
    private var profile_path: String?
    var job: String
    var profileImage: String? {
        if let profilePicture = profile_path {
            var components = Utils.imageURL
            components.path = "/t/p/w500\(profilePicture)"
            return components.string!
        }
        return nil
    }
}
