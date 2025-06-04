//
//  ListView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import Foundation

//MARK: Generic List View Model that contains the
class ItemListViewModel: ObservableObject{
    @Published var models : [Item] = []
    @Published var selectedModel: Item?
    
    private var service: APIService = APIService()
    private var keychain: KeyChainHandler = KeyChainHandler()
    
    //MARK: Fetch Items from the API Service
    func fetchModels(){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                print("Found token when fetching items")
                models = try await service.getItems(token: authTokenName)
            }
            print("Found \(models.count) items")
        }
    }
    
    //MARK: Fetch Items by ID from the API Service
    func fetchModel(id: Int){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                selectedModel = try await service.getItems(token: token, id: id)
            }
        }
    }
    
}
