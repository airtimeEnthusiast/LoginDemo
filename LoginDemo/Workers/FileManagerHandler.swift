//
//  FileManagerHandler.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
// Reference: https://medium.com/@shashidj206/mastering-filemanager-in-swift-and-swiftui-7f29d6247644

import Foundation

class FileManagerHandler: ObservableObject {
    // Shared manager object
    private let fileManager = FileManager.default
    private let documentsURL: URL
    
    //MARK: File names
    private let usersFileName = "users.json"
    private let itemsFileName = "items.json"
    
    init() {
        documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // MARK: Save Methods
    func saveUsers(_ users: [Users]) {
        save(users, to: usersFileName)
    }
    
    // MARK: Save Items
    func saveItems(_ items: [Item]) {
        save(items, to: itemsFileName)
    }
    
    // MARK: Generic Save Objects to a file
    private func save<T: Codable>(_ data: T, to fileName: String) {
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: fileURL)
            print("Saved to \(fileName)")
        } catch {
            print("Failed to save \(fileName):", error.localizedDescription)
        }
    }
    
    // MARK: Load Users
    func loadUsers() -> [Users] {
        return load(from: usersFileName)
    }
    
    //MARK: Load Items
    func loadItems() -> [Item] {
        return load(from: itemsFileName)
    }
    
    // MARK: Generic Load Objects from a file
    private func load<T: Codable>(from fileName: String) -> [T]{
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try JSONDecoder().decode([T].self, from: data)
            return decoded
        } catch {
            print("Failed to load \(fileName):", error.localizedDescription)
            return []
        }
    }
}
