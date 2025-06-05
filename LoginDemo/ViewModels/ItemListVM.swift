//
//  ListView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import Foundation

//MARK: Generic List View Model that contains the fetch calls for items
class ItemListViewModel: ObservableObject{
    @Published var models : [Item] = []
    @Published var comments : [Comments] = []
    @Published var selectedModel: Item?
    
    private var service: APIService = APIService()
    private var keychain: KeyChainHandler = KeyChainHandler()
    private var fileManager: FileManagerHandler = FileManagerHandler()
    
    //MARK: Fetch Items from the API Service
    func fetchModels(retryAttempts: Int = 2){
        Task{
            //If the users exists in the FileManager
            let cachedModels = fileManager.loadItems()
            if !cachedModels.isEmpty {
                DispatchQueue.main.async {
                    self.models = cachedModels
                }
            } else{
                // If the login token exists
                if let token = try keychain.query(authTokenName) {
                    do{
                        print("Found token when fetching users")
                        let result = try await service.getItems(token: token)
                        
                        DispatchQueue.main.async {
                            self.models = result
                            self.fileManager.saveItems(self.models)
                        }
                    } catch {//  Handle fetch errors
                        print("Failed to load item models: \(error)")
                        if retryAttempts > 0 {
                            try? await Task.sleep(1)
                            fetchModels(retryAttempts: retryAttempts - 1) // Attempt to make another request
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Fetch Items by ID from the API Service
    func fetchModel(id: Int, retryAttempts: Int = 2){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                do {
                    selectedModel = try await service.getItems(token: token, id: id)
                }catch { // Handle fetch errors
                    if retryAttempts > 0 {
                        print("Failed to load item model: \(error)")
                        try? await Task.sleep(1)
                        fetchModel(id: id, retryAttempts: retryAttempts - 1) // Attempt to make another request
                    }
                }
            }
        }
    }
    
    //MARK: Fetch Comments from the API Service
    func fetchModelsComments(id: Int, retryAttempts: Int = 2){
        Task{
            // If the login token exists
            if let token = try keychain.query(authTokenName) {
                print("Found token when fetching items")
                do {
                    let result = try await service.getItems_Comments(token: token, id: id)
                    DispatchQueue.main.async {
                        self.comments = result
                    }
                }catch { // Handle fetch errors
                    if retryAttempts > 0 {
                        print("Failed to load item comments: \(error)")
                        try? await Task.sleep(1)
                        fetchModelsComments(id:id, retryAttempts: retryAttempts - 1) // Attempt to make another request
                    }
                }
            }
        }
    }
    
    
}
