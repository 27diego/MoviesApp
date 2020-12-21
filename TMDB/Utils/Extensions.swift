//
//  Extensions.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import SwiftUI
import Foundation
import Combine

extension URLSession {
    func publisher<T: Codable> (for url: URL, responseType: T.Type = T.self, decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error>{
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let publisher = dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: responseType, decoder: decoder)
            .eraseToAnyPublisher()
        
        return publisher
    }
}

extension UIScreen {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}

