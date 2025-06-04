//
//  SettingsView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUICore
import SwiftUI

//MARK: Contains settings features
struct SettingsView: View {
    private var keychain = KeyChainHandler()
    private var auth: Authenticator
    
    init(auth: Authenticator) {
        self.auth = auth
    }
    
    var body: some View {
        Form{
            Section(header: Text("General")){
                Button(action: {
                    signOut()
                }, label: {
                    Text("Log Out")
                }).accessibilityIdentifier("logOffButton")
            }
        }
    }
    
    //MARK: Sign out of the app and delete the login token.
    func signOut() {
        do{
            try keychain.delete(authTokenName)
        } catch {
            print("Error deleting keychain item: \(error)")
        }
        auth.updateAuthenticationState(false)
    }
}
