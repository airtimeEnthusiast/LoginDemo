//
//  KeyChainHandler.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//
import Foundation
import Security

//MARK: Handle keychain functionality
final class KeyChainHandler{
    static let instance = KeyChainHandler()
    
    // Error handling
    enum KeychainError: Error {
            case duplicateEntry
            case unknown(OSStatus)
        }
    
    //MARK: Save a token to keychain
    func save(_ token: String, forKey key: String) throws{
        if let data = token.data(using: .utf8) {
            // Prepair the data dictionary
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]
            // Attempt to add the query to the keychain
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateEntry
            }
            
            guard status == errSecSuccess else {
                throw KeychainError.unknown(status)
            }
        }
    }
    
    //MARK: Query a token from keychain
    func query(_ key: String) throws -> String? {
        
        //Data to be retrieved
        var dataTypeRef: AnyObject?
        
        // Prepair the data dictionary
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        // Attempt to add the query to the keychain
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    //MARK: Delete a token from keychain
    func delete(_ key: String) throws {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            SecItemDelete(query as CFDictionary)
    }
}
