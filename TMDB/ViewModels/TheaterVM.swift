//
//  TheaterVM.swift
//  TMDB
//
//  Created by Developer on 12/29/20.
//q

import Foundation
import Combine

class Theater: ObservableObject {
    @Published var selectedSeats: [Seat] = .init()
    @Published var selectedDate: TicketDate = .init(day: "", month: "", year: "")
    @Published var selectedHour: String = ""
    @Published var continueButton: Bool = false
    
    var movie: Int
    var dates: [TicketDate] = Date.getFollowingThirtyDays()
    var hours: [String] = Date.getRemainingHours()
    var cancellables: Set<AnyCancellable> = .init()
    
    init(for movie: Int){
        self.movie = movie
        setUpPublishers()
    }
    
    func setUpPublishers() {        
        Publishers.CombineLatest3($selectedSeats, $selectedDate, $selectedHour)
            .map { seats, date, hour -> Bool in
                if seats.count > 0 && seats.count < 5 && date.day != "" && hour != ""  {
                    return false
                }
                
                return true
            }
            .sink { res in
                self.continueButton = res
            }
            .store(in: &cancellables)
    }
    
    func selectDate(date: TicketDate) {
        if date == selectedDate {
            selectedDate = TicketDate.init(day: "", month: "", year: "")
        }
        else {
            selectedDate = date
        }
    }
    func selectHour(hour: String) {
        if selectedHour == hour {
            selectedHour = ""
        }
        else {
            selectedHour = hour
        }
    }
}
