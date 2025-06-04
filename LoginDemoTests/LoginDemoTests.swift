//
//  LoginDemoTests.swift
//  LoginDemoTests
//
//  Created by Austin Wright on 6/4/25.
//

import XCTest

// MARK: Test the API Services
final class LoginDemoTests: XCTestCase {

    let service = APIService()
    
    //MARK: Test sucessful POST on login to recieve a JWT
    func testPostLoginToken_Success() async throws {
        let credentials = Credentials(username: "test", password: "password123")
        
        do {
            let response = try await service.postLoginToken(credentials: credentials)
            XCTAssertEqual(response.loginToken.token, "fake-jwt-token", "Expected token to match mock token")
        } catch {
            XCTFail("Login request failed with error: \(error)")
        }
    }
    
    //MARK: Test sucesful retrieval of items
    func testGetItems_Success() async throws {
        let jwtToken = "fake-jwt-token"
        
        do {
            let response = try await service.getItems(token: jwtToken)
            XCTAssertGreaterThan(response.count, 2, "Expected to retrieve more than 2 items")
        } catch {
            XCTFail("Item retrieval failed with error: \(error)")
        }
    }
    
    //MARK: Test sucesful retrieval of users
    func testGetUsers_Success() async throws {
        let jwtToken = "fake-jwt-token"
        
        do {
            let response = try await service.getUsers(token: jwtToken)
            XCTAssertGreaterThan(response.count, 2, "Expected to retrieve more than 2 users")
        } catch {
            XCTFail("Item retrieval failed with error: \(error)")
        }
    }
    
    //MARK: Test sucesful retrieval of an item by ID
    func testGetItem_By_ID_Success() async throws {
        let jwtToken = "fake-jwt-token"
        let id = 2
        do {
            let response = try await service.getItems(token: jwtToken, id: id)
            XCTAssertNotNil(response, "Expected to retrieve an item")
        } catch {
            XCTFail("Item retrieval failed with error: \(error)")
        }
    }
    
    //MARK: Test sucesful retrieval of an item by ID
    func testGetUser_By_ID_Success() async throws {
        let jwtToken = "fake-jwt-token"
        let id = 2
        do {
            let response = try await service.getUsers(token: jwtToken, id: id)
            XCTAssertNotNil(response, "Expected to retrieve an item")
        } catch {
            XCTFail("Item retrieval failed with error: \(error)")
        }
    }
    
    //MARK: Test sucesful retrieval of item comments by ID
    func testGetItem_By_ID_Comments_Success() async throws {
        let jwtToken = "fake-jwt-token"
        let id = 2
        do {
            let response = try await service.getItems_Comments(token: jwtToken, id: id)
            XCTAssertGreaterThan(response.count, 2, "Expected to retrieve more than 2 items")
        } catch {
            XCTFail("Item retrieval failed with error: \(error)")
        }
    }


}
