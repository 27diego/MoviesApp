//
//  TheaterOrderConfirmationView.swift
//  TMDB
//
//  Created by Developer on 12/31/20.
//

import SwiftUI

struct OrderPaymentView: View {
    @ObservedObject var orderPayment: OrderPaymentVM
    var body: some View {
        VStack {
            Form {
                VStack(alignment: .leading) {
                    Section {
                        Text("Select Payment Method")
                            .foregroundColor(.gray)
                        Picker("", selection: $orderPayment.paymentMethod) {
                            ForEach(PaymentTypeEnum.allCases, id: \.self){ method in
                                Text(method.description).tag(method)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .padding(10)
                
                Section(header: Text(orderPayment.paymentMethod == .paypal ? "PayPal account" : "Card Payment"), footer: Button("Pay"){}
                            .buttonStyle(CustomButtonStyle(color: .blue))) {
                    if orderPayment.paymentMethod == .masterCard {
                        CardFormView(cardHolderName: $orderPayment.cardHolderName, cardNumber: $orderPayment.cardNumber, expireDate: $orderPayment.expireDate, cvv: $orderPayment.cvv, image: "MasterCard")
                    }
                    else if orderPayment.paymentMethod == .visa {
                        CardFormView(cardHolderName: $orderPayment.cardHolderName, cardNumber: $orderPayment.cardNumber, expireDate: $orderPayment.expireDate, cvv: $orderPayment.cvv, image: "Visa")
                    }
                    else {
                        
                        PayPalFormView(paypalUsername: $orderPayment.paypalUsername, paypalPassword: $orderPayment.paypalPassword)
                    }
                }
                
            }
            .animation(.easeInOut)
        }
        .navigationBarTitle("Payment")
    }
}

struct TheaterOrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderPaymentView(orderPayment: OrderPaymentVM(for: 12.95))
    }
}

struct CardFormView: View {
    @Binding var cardHolderName: String
    @Binding var cardNumber: String
    @Binding var expireDate: String
    @Binding var cvv: String
    
    var image: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                TextField("Cardholder Name", text: $cardHolderName)
                    .padding(.vertical)
            }
            HStack {
                Image(systemName: "number")
                    .foregroundColor(.gray)
                TextField("Card Number", text: $cardNumber)
                    .padding(.vertical)
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
            }
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                TextField("Expire Date", text: $expireDate)
                    .padding(.vertical)
            }
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                TextField("CVV", text: $cvv)
                    .padding(.vertical)
            }
        }
    }
}

struct PayPalFormView: View {
    @Binding var paypalUsername: String
    @Binding var paypalPassword: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                TextField("Username", text: $paypalUsername)
                    .padding(.vertical)
            }
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("Password", text: $paypalPassword)
                Image("Paypal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
            }
        }
    }
}
