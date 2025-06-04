//
//  LoginDemoApp.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

@main
struct LoginDemoApp: App {
    @StateObject var auth = Authenticator()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(auth)
        }
    }
}
