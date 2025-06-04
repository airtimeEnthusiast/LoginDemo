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
    
    func updateAuthenticationState(_ isAuthenticated:Bool) {
        DispatchQueue.main.async {
            withAnimation {
                self.isAuthenticated = isAuthenticated
            }
        }
    }
    
}
