//
//  Authenticator.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
// Reference: https://github.com/StewartLynch/My-Secure-App---Part1-Completed/blob/main/My%20Secure%20App/Authentication.swift

import Foundation
import SwiftUI

// MARK: Enviromental state control to determine whether the user is logged in.
class Authenticator:ObservableObject {
    @Published var isAuthenticated:Bool = false
    private var keychain = KeyChainHandler()
    
    init() {
        self.hasForAuthentication("authToken")
    }
    
    //MARK: Check for a login token
    func hasForAuthentication(_ key: String){
        let response = try? keychain.query(key)
        if response != nil {
            self.isAuthenticated = true
        }
    }
    
    //MARK: Update authentication state dynamically during log in or sign out
    func updateAuthenticationState(_ isAuthenticated:Bool) {
        DispatchQueue.main.async {
            withAnimation {
                self.isAuthenticated = isAuthenticated
            }
        }
    }
    
}
