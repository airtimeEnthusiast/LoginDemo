//
//  ItemDetailView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//
import SwiftUI
import Kingfisher

//MARK: Item Detail View
struct ItemDetailView: View {
    var item: Item
    @StateObject private var vm = ItemDetailViewModel()
    var body: some View {
        ScrollView{
            VStack{
                Text("Details for \(item.id)")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .font(.headline)
                    .tracking(4)
                VStack{
                    Divider()
                    // ID field
                    HStack{
                        Text("ID")
                        Spacer()
                        Text("\(item.id)")
                    }.padding(.horizontal)
                    Divider()
                    // Title field
                    HStack{
                        Text("Title")
                        Spacer()
                        Text("\(item.title)")
                    }.padding(.horizontal)
                    // User field
                    Divider()
                    HStack{
                        Text("User ID")
                        Spacer()
                        Text("\(item.userId)")
                    }.padding(.horizontal)
                    Divider()
                    // Summary field
                    HStack{
                        Text("Summary")
                        Spacer()
                        Text("\(item.summary)")
                    }.padding(.horizontal)
                    Divider()
                    // If author has not been received, show progress view
                    if vm.author == nil{
                        ProgressView()
                    }
                    else{ // Show navigation link to authors page
                        NavigationLink{
                            UsersDetailView(users: vm.author!)
                        }label:{
                            HStack{
                                Text("Author Details")
                            }
                        }
                    }
                    // Image
                    KFImage(URL(string: item.image))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                VStack{
                    ItemCommentsView(item: item)
                }
            }
        }.onAppear{ // Fetch author of item
            withAnimation{
                vm.getAuthor(id: item.userId)
            }
        }
        .refreshable {
            vm.getAuthor(id: item.userId)
            vm.loadComments(id: item.id)
        }
    }
}
#Preview {
    ItemDetailView(item: Item(id: 0, title: "title", summary: "summary", userId: 1, image: "image"))
}
