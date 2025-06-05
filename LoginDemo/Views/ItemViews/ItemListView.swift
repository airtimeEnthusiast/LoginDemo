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
                if let model = vm.selectedModel { // Show searched entry
                    NavigationLink{
                        ItemDetailView(item: model)
                    }label:{
                        Text(model.title)
                    }
                }else if(vm.models.isEmpty){
                    ProgressView()
                }
                else{ // Show entire list if the list isn't being searched
                    ForEach(vm.models, id: \.self){ model in
                        NavigationLink{
                            ItemDetailView(item: model)
                        }label:{
                            Text(model.title)
                        }
                    }
                }
            }.onAppear{ // Fetch models upon view load
                populateList()
            }
            .searchable(text: $searchText) // add searchable proporty
            .submitLabel(.search)   // add search button to the keyboard
            .onSubmit(of: .search) {
                performSearch() // add search button to the keyboard
            }
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {    // make the selected model nil if there is no searchtext
                    vm.selectedModel = nil
                }
            }
            .refreshable { // make the list refresh the model with a fetch of data
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
