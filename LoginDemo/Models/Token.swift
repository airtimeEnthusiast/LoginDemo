//
//  Token.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

//MARK: Authentication Token Name
let authTokenName = "authToken"

//MARK: Parent of the Authentication token
struct LoginResponse: Codable {
    let loginToken: Token
}

//MARK: Consuming the JWT token from the login API Endpoint
struct Token: Codable {
    let token: String
    let user: User
}
