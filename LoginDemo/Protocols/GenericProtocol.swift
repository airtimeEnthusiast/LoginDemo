//
//  ModelProtocol.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

//MARK: General object protocol for displaying in lists, used in a dictionary and can be decoded and encoded
protocol ModelProtocol: Identifiable, Hashable, Codable {}
