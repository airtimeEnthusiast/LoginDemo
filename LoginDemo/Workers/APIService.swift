//
//  APIService.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//
// Reference: https://designcode.io/swiftui-advanced-handbook-async-await

import Foundation

//MARK: Contains functions to preform calls and responses to the API endpoint
class APIService{
    
    //MARK: Handles login requests and returns a jwt. Referenced Postman's generated code
    func postLoginToken(credentials: Credentials) async throws -> LoginResponse {
        // Configre the endpoint url
        let url = URL(string: Endpoints["login"]!)!
        
        // Configure the request
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // Configure the parameters
        let body: [String: String] = [
            "username": credentials.username,
            "password": credentials.password
        ]
        request.httpBody = try JSONEncoder().encode(body)

        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)


        // Decode the response
        do {
            let tokenResponse = try JSONDecoder().decode(Token.self, from: data)
            return LoginResponse(loginToken: tokenResponse)
        } catch {
            throw error // rethrow decoding error
        }
    }
    
    //MARK: Handles get Items request on a list of Items.
    func getItems(token: String) async throws -> [Item] {
        // Configre the endpoint url
        let url = URL(string: Endpoints["getItems"]!)!
        
        // Configure the request
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)

        // Decode the response
        do {
            let listResponse = try JSONDecoder().decode([Item].self, from: data)
            return listResponse
        } catch {
            throw error // rethrow decoding error
        }
    }
    
    //MARK: Handles get Items on a single item from Id
    func getItems(token: String, id: Int) async throws -> Item {
        // Configre the endpoint url
        let url = URL(string: Endpoints["getItems"]! + "/" + "\(id)")!
        
        
        // Configure the request
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)

        // Decode the response
        do {
            let listResponse = try JSONDecoder().decode(Item.self, from: data)
            return listResponse
        } catch {
            throw error // rethrow decoding error
        }
    }
    
    //MARK: Handles get Users request on a list of Users.
    func getUsers(token: String) async throws -> [Users] {
        // Configre the endpoint url
        let url = URL(string: Endpoints["getUsers"]!)!
        
        // Configure the request
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)

        // Decode the response
        do {
            let listResponse = try JSONDecoder().decode([Users].self, from: data)
            return listResponse
        } catch {
            throw error // rethrow decoding error
        }
    }
    
    //MARK: Handles get Items request on a single Users.
    func getUsers(token: String, id: Int) async throws -> Users {
        // Configre the endpoint url
        let url = URL(string: Endpoints["getUsers"]! + "/" + "\(id)")!
        
        // Configure the request
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)


        // Decode the response
        do {
            let listResponse = try JSONDecoder().decode(Users.self, from: data)
            return listResponse
        } catch {
            throw error // rethrow decoding error
        }
    }
    
    //MARK: Handles get Items request on a single Users.
    func getItems_Comments(token: String, id: Int) async throws -> [Comments] {
        // Configre the endpoint url
        let url = URL(string: Endpoints["getItems"]! + "/" + "\(id)" + "/comments")!
        
        // Configure the request
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)


        // Decode the response
        do {
            let listResponse = try JSONDecoder().decode([Comments].self, from: data)
            return listResponse
        } catch {
            throw error // rethrow decoding error
        }
    }
}
