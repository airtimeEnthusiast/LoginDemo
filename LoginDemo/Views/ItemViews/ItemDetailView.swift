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
                    HStack{
                        Text("ID")
                        Spacer()
                        Text("\(item.id)")
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        Text("Title")
                        Spacer()
                        Text("\(item.title)")
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        Text("User ID")
                        Spacer()
                        Text("\(item.userId)")
                    }.padding(.horizontal)
                    Divider()
                    HStack{
                        Text("Summary")
                        Spacer()
                        Text("\(item.summary)")
                    }.padding(.horizontal)
                    Divider()
                    KFImage(URL(string: item.image))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                VStack{
                    ItemCommentsView(item: item)
                }
            }
        }
    }
}
#Preview {
    ItemDetailView(item: Item(id: 0, title: "title", summary: "summary", userId: 1, image: "image"))
}
