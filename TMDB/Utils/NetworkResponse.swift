//
//  NetworkResponse.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {
    let results: [T]
}
