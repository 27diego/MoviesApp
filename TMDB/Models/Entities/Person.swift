//
//  Person.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

// MARK: - maybe should be a struct?
protocol Person: Identifiable {
    var id: Int { set get }
    var name: String { set get }
    var profilePath: String? { set get  }
}

struct PersonModel: Codable, Identifiable, Person {
    var id: Int
    var name: String
    var profilePath: String?
    var popularity: Double
}

struct Actor: Codable, Identifiable, Person {
    var id: Int
    var name: String
    var profilePath: String?
    var order: Int
    var popularity: Double
    var character: String
}

struct CrewMember: Codable, Identifiable, Person {
    var id: Int
    var name: String
    var profilePath: String?
    var department: String
    var job: String
}

struct PersonDetails: Codable {
    let id: Int
    let name: String
    let birthday: String?
    let biography: String
    let popularity: Double
    let placeOfBirth: String
    let profilePath: String?
}

struct PersonCreditResults: Codable {
    let id: Int
    let cast: [MovieModel]
    let crew: [MovieModel]
}

struct PersonImages: Codable, Hashable {
    let filePath: String?
}

struct PersonImagesResults: Codable {
    let id: Int
    let profiles: [PersonImages]
}

enum PersonType {
    case popular
    
    var description: String {
        switch self {
        case .popular:
            return "person/popular"
        }
    }
}
