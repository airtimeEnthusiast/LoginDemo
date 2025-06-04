//
//  ItemListView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//
import SwiftUI

// MARK: List of Items
struct ItemListView: View {
    @StateObject private var vm: ItemListViewModel = ItemListViewModel()
    @State private var searchText: String = ""

    var body: some View {
        NavigationSplitView {
            List {
            //MARK: Show entire list if the list isn't being searched
                if let model = vm.selectedModel {
                    if let item = vm.selectedModel {
                        NavigationLink{
                            ItemDetailView(item: item)
                        }label:{
                            Text(item.title)
                        }
                    }
                } else{
                    ForEach(vm.models, id: \.self){ model in
                        NavigationLink{
                            ItemDetailView(item: model)
                        }label:{
                            Text(model.title)
                        }
                    }
                }
            }.onAppear{
                if vm.models.isEmpty{
                    vm.fetchModels()
                }
            }
            .searchable(text: $searchText)
            .submitLabel(.search)
            .onSubmit(of: .search) {
                performSearch()
            }
            .onChange(of: searchText) { newValue in
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
