//
//  SignIn.swift
//  TMDB
//
//  Created by Developer on 1/2/21.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var auth: SignInVM
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("TMDB")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Username", text: $auth.username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                SecureField("Password", text: $auth.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
                Button("Go!"){
                    isLoggedIn = auth.logIn()
                }
                .buttonStyle(CustomButtonStyle(color: auth.disableLink ? .gray : .blue))
                .padding(10)
                .disabled(auth.disableLink)
                
                
            }
            .padding()
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(auth: SignInVM(), isLoggedIn: .constant(false))
    }
}
