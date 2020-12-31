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

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


// MARK: - Review
extension Date{
     static var thisYear: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let component = formatter.string(from: Date())
        
        if let value = Int(component) {
            return value
        }
        return 0
    }
    
    private static func getComponent(date: Date, format: String) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = format
        formatter.locale = Locale.autoupdatingCurrent
           let component = formatter.string(from: date)
           return component
    }
    
    static func getFollowingThirtyDays(for month: Int = 1) -> [TicketDate]{
        var dates = [TicketDate]()
        let dateComponents = DateComponents(year: thisYear , month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        
        for i in range {
            guard let fullDate = calendar.date(byAdding: DateComponents(day: i) , to: Date()) else { continue }
            let d = getComponent(date: fullDate, format: "dd")
            let m = getComponent(date: fullDate, format: "MM")
            let y = getComponent(date: fullDate, format: "yy")
            let ticketDate = TicketDate(day: d, month: m, year: y)
            dates.append(ticketDate)
        }
        
        return dates
        
    }
}
