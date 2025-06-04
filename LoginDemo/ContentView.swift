//
//  ContentView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: Authenticator
    var body: some View {
        //Switch to the main app views when the user is logged in
        if auth.isAuthenticated {
            Text("Logged in!")
        }
        else{
            LoginView(auth: auth)
        }
    }
}

#Preview {
    ContentView()
}
