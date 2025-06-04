//
//  Users.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

//MARK: User is a member of the Token class (JWT Token)
struct User: ListProtocol {
    let id: Int
    let name: String
}

//MARK: Consuming the member of the user's list
struct Users: Codable, Hashable, Identifiable, ListProtocol {
    let id: Int
    let name: String?
    let email: String
    let avatar: String
}
