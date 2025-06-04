//
//  UserListVM.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import Foundation

//MARK: Generic List View Model that contains the fetch calls for items
class UsersListViewModel: ObservableObject{
    @Published var models : [Users] = []
    @Published var selectedModel: Users?
    
    private var service: APIService = APIService()
    private var keychain: KeyChainHandler = KeyChainHandler()
    
    //MARK: Fetch Items from the API Service
    func fetchModels(){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                print("Found token when fetching items")
                let result = try await service.getUsers(token: token)
                DispatchQueue.main.async {
                    self.models = result
                }
            }
        }
    }
    
    //MARK: Fetch Items by ID from the API Service
    func fetchModel(id: Int){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                selectedModel = try await service.getUsers(token: token, id: id)
            }
        }
    }
}
