//
//  Token.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//
//MARK: Parent of the JWT token
struct LoginResponse: Codable {
    let loginToken: Token
}

//MARK: Consuming the JWT token from the login API Endpoint
struct Token: Codable {
    let token: String
    let user: User
}
