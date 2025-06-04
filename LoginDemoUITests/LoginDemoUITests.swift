//
//  LoginDemoUITests.swift
//  LoginDemoUITests
//
//  Created by Austin Wright on 6/4/25.
//
// Reference: https://medium.com/appledeveloperacademy-ufpe/how-to-implement-ui-tests-with-swiftui-a-few-examples-636708ee26ad
import XCTest

final class LoginDemoUITests: XCTestCase {
    func testLoginDemo() throws {
        let app = XCUIApplication()
        app.launch()
        
        //Locate UI Fields and Button
        let usernameField = app.textFields["username_field"]
        let passwordField = app.secureTextFields["password_field"]
        let loginButton = app.buttons["login_button"]
        
        XCTAssertTrue(usernameField.waitForExistence(timeout: 2))
        XCTAssertTrue(passwordField.waitForExistence(timeout: 2))
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2))
        
        usernameField.tap()
        usernameField.typeText("test")

        passwordField.tap()
        passwordField.typeText("password123")

        loginButton.tap()
        
        sleep(2)
        
    }
}
