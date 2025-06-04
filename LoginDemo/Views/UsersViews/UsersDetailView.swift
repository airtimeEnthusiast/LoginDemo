//
//  UserDetailView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI
import Kingfisher

//MARK: Users Detail View
struct UsersDetailView: View {
    var users: Users
    @StateObject private var vm = ItemDetailViewModel()
    var body: some View {
        ScrollView{
            VStack{
                KFImage(URL(string: users.avatar ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.blue.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(50)
                VStack{
                    Divider()
                    HStack{
                        Text(users.name ?? "No name").bold()
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        Text("ID")
                        Spacer()
                        Text("\(users.id)")
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        Text("Email")
                        Spacer()
                        Text("\(users.email)")
                    }.padding(.horizontal)
                    Divider()
                }
            }
        }
    }
}

