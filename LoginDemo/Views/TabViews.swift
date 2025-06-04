//
//  TabViews.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

//MARK: Contains the a collection of tabs
struct TabCollectionViews: View {
    var auth: Authenticator
    
    var body: some View {
        TabView{
            ItemListView()
                .tabItem {
                    Label("Items", systemImage: "shippingbox")
                }
            UsersListView()
                .tabItem {
                    Label("Users", systemImage: "person")
                }
            SettingsView(auth: auth).tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}
