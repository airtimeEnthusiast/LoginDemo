//
//  ItemListView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//
import SwiftUI
struct ItemListView: View {
    @StateObject private var vm: ItemListViewModel = ItemListViewModel()
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(vm.models, id: \.self){ model in
                    NavigationLink{
                        ItemDetailView()
                    }label:{
                        Text(model.title)
                    }
                }
            }.onAppear(){
                if vm.models.isEmpty{
                    vm.fetchModels()
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
}
