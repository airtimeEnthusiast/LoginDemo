//
//  TabViews.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

struct TabCollectionViews: View {
    var auth: Authenticator
    
    var body: some View {
        TabView{
            ItemListView()
                .tabItem {
                    Label("Items", systemImage: "shippingbox")
                }
            SettingsView(auth: auth).tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}
