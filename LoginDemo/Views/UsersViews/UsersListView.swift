//
//  UserListView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

// MARK: List of Users
struct UsersListView: View {
    @StateObject private var vm: UsersListViewModel = UsersListViewModel()
    @State private var searchText: String = ""

    var body: some View {
        NavigationSplitView {
            List {
                if let model = vm.selectedModel {
                    NavigationLink{
                        UsersDetailView(users: model)
                    }label:{
                        Text(model.name ?? "No name")
                    }
                } else{ // Show entire list if the list isn't being searched
                    ForEach(vm.models, id: \.self){ model in
                        NavigationLink{
                            UsersDetailView(users: model)
                        }label:{
                            Text(model.name ?? "No Name")
                        }
                    }
                }
            }.onAppear{ // Fetch models upon view load
                if vm.models.isEmpty{
                    vm.fetchModels()
                }
            }
            .searchable(text: $searchText) // add searchable proporty
            .submitLabel(.search) // add search button to the keyboard
            .onSubmit(of: .search) {
                performSearch() // add search button to the keyboard
            }
            .onChange(of: searchText) { newValue in // make the selected model nil if there is no searchtext
                if newValue.isEmpty {
                    vm.selectedModel = nil
                }
            }
            .refreshable {
                vm.fetchModels()
            }
            .navigationTitle(Text("Items"))
        } detail: {
            Text("Select a row")
        }
    }
    
    //MARK: handle loading of data models to the list
    func populateList(){
        vm.fetchModels()
    }
    
    //MARK: Search for an item by ID
    func performSearch() {
        print("Searching for: \(searchText)")
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if let id = Int(trimmed) {
            vm.fetchModel(id: id)   // Call API Service
        } else {
            vm.selectedModel = nil
        }
    }
}

