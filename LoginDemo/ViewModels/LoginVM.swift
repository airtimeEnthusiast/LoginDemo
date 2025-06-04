//
//  LoginVM.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    //Instance of API Service
    let apiService = APIService()
    
    // Instance of Authenticator
    private var auth: Authenticator
    
    //MARK: Inject authentor into the VM
    init(auth: Authenticator) {
        self.auth = auth
    }
    
    //MARK: Login into the App
    func login(){
        if username.isEmpty || password.isEmpty {
            print("Please enter both username and password")
            return
        }
        else{
            Task{
                do{
                    // Request a login token
                    print("Entered Credentials: \(username), \(password)")
                    let response = try await apiService.postLoginToken(credentials: Credentials(username: username, password: password))
                    print("Response Token: \(response.loginToken.token)")
                    auth.updateAuthenticationState(true)
                    // Check for a valid token response
                    if response.loginToken == nil{
                        if response.loginToken.token == "fake-jwt-token"
                        {
                            print("Sucessfully Logged In")
                            return
                        }
                        else{
                            print("Invalid Credentials or Token not received \(response.loginToken.token)")
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                return
            }
        }
        return 
    }
}
