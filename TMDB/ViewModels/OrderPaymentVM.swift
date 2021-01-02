//
//  OrderPaymentVM.swift
//  TMDB
//
//  Created by Developer on 1/1/21.
//

import Foundation
import Combine

class OrderPaymentVM: ObservableObject {
    var price: Double
    @Published var paymentMethod: PaymentTypeEnum = .masterCard
    @Published var cardHolderName: String = ""
    @Published var cardNumber: String = ""
    @Published var expireDate: String = ""
    @Published var cvv: String = ""
    @Published var isSendingPending: Bool = false
    @Published var paymentSent: Bool = false
    
    @Published var paypalUsername: String = ""
    @Published var paypalPassword: String = ""
    
    
    init(for price: Double){
        self.price = price
    }
    
    func checkOut() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSendingPending = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.paymentSent = true
        }
    }
}


enum PaymentTypeEnum: String, CaseIterable {
    case masterCard, visa, paypal
    
    var description: String {
        switch self{
        case .masterCard:
            return "Master Card"
        case .paypal:
            return "PayPal"
        case.visa:
            return "Visa"
        }
    }
}
