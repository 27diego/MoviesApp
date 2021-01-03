//
//  SignInVM.swift
//  TMDB
//
//  Created by Developer on 1/2/21.
//

import Foundation
import Combine

class SignInVM: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var disableLink: Bool = true
    
    init(){
        setUpSubscribers()
    }
    
    func setUpSubscribers() {
        Publishers.CombineLatest($username, $password)
            .map { username, password -> Bool in
                guard self.validateUsername(for: username) && self.validatePassword(for: password) && username != password else { return true }
                return false
            }
            .assign(to: &$disableLink)
    }
    
    func validateUsername(for username: String) -> Bool {
        if username.count >= 5 {
            return true
        }
        
        return false
    }
    
    func validatePassword(for password: String) -> Bool {
        if password.count >= 5 {
            return true
        }
        
        return false
    }
    
    func logIn() -> Bool {
        guard self.username == "Diego" && self.password == "Vegas" else { return false }
        return true
    }
}
