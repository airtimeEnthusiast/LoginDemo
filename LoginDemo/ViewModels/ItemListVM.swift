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
            // If token exists
            if let token = try keychain.query(authTokenName) {
                
            }
            models = try await service.getItems(token: authTokenName)
        }
    }
    
}
