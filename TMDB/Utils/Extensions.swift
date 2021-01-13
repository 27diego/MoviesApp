//
//  Extensions.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import SwiftUI
import Foundation
import Combine
import CoreData

extension URLSession {
    func publisher<T: Codable> (for url: URL, responseType: T.Type = T.self, decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error>{
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let publisher = dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: responseType, decoder: decoder)
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    func publisher<T:Codable>(for url: URL, responseType: T.Type = T.self, decoder: JSONDecoder = .init(), context: NSManagedObjectContext) -> AnyPublisher<T, Error> {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.userInfo[.managedObjectContext] = context
        
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


extension Date {
    static var thisYear: Int {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date: String = formatter.string(from: Date())
        
        if let value = Int(date) {
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
        
        let range: Range<Int> = calendar.range(of: .day, in: .month, for: date)!
        
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
    
    static func getRemainingHours() -> [String] {
        var results: [String] = []
        let calendar = Calendar.current
        let today = calendar.dateComponents([.day, .hour], from: Date())
        let todaysHours = DateComponents(day: today.day, hour: today.hour)
        let hourRange = calendar.range(of: .hour, in: .day, for: Calendar.current.date(from: todaysHours)!)!

        for i in hourRange {
            let fullHour = calendar.date(byAdding: DateComponents(hour: i), to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            results.append(formatter.string(from: fullHour))
        }
        return results
    }
}


struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    public mutating func dismiss() {
        self.toggle()
    }
}
