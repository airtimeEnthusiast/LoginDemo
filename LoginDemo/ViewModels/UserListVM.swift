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
    private var fileManager: FileManagerHandler = FileManagerHandler()
    
    //MARK: Fetch Items from the API Service
    func fetchModels(retryAttempts: Int = 3){
        Task{
            //If the users exists in the FileManager
            let cachedModels = fileManager.loadUsers()
            if !cachedModels.isEmpty {
                DispatchQueue.main.async {
                    self.models = cachedModels
                }
            } else{
                // If the login token exists
                if let token = try keychain.query(authTokenName) {
                    do{
                        print("Found token when fetching items")
                        let result = try await service.getUsers(token: token)
                        DispatchQueue.main.async {
                            self.models = result
                            self.fileManager.saveUsers(self.models)
                        }
                    } catch {
                        if retryAttempts > 0 {
                            print("Failed to load user models: \(error)")
                            try? await Task.sleep(1)
                            fetchModels(retryAttempts: retryAttempts - 1) // Attempt to make another request
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Fetch Items by ID from the API Service
    func fetchModel(id: Int, retryAttempts: Int = 3){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                do{
                    selectedModel = try await service.getUsers(token: token, id: id)
                } catch {
                    if retryAttempts > 0 {
                        print("Failed to load user model: \(error)")
                        try? await Task.sleep(1)
                        fetchModel(id: id, retryAttempts: retryAttempts - 1) // Attempt to make another request
                    }
                }
            }
        }
    }
}
