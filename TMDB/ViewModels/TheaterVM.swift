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
    
    var dates: [TicketDate] = Date.getFollowingThirtyDays()
    var hours: [String] = Date.getRemainingHours()
    var cancellables: Set<AnyCancellable> = .init()
    
    init(){
        setUpPublishers()
    }
    
    func setUpPublishers() {
        //use combine latest to validate fields and enable continue buttont
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
