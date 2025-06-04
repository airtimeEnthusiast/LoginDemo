//
//  Comments.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

//MARK: Consuming the Comments GET API Endpoint
struct Comments: Codable, Identifiable {
    let id: Int
    let author: String
    let message: String
    let timestamp: String
}
