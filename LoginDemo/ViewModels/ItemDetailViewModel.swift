//
//  ItemDetailView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import Foundation

//MARK: Controls the data between an Item's details page and the API Service worker
class ItemDetailViewModel: ObservableObject {
    
    // Local list of comments
    @Published var comments: [Comments] = []

    // API Service instance
    private let apiService = APIService()
    
    //Keychain instance
    private var keychain: KeyChainHandler = KeyChainHandler()

    //MARK: Handle state changes when fetching comments from the API Endpoint
    func loadComments(id itemId: Int) {
        // Handle async work concurrently
        Task {
            do {
                // Check for auth token before requesting
                if let token = try keychain.query(authTokenName) {
                    // fetch the comments
                    let result = try await apiService.getItems_Comments(token: token, id: itemId)
                    // Update the comments page on the main thread
                    DispatchQueue.main.async {
                        self.comments = result
                    }
                }
            } catch { // Catch general errors when loading comments
                print("Failed to load comments: \(error)")
            }
        }
    }
}
