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
    
    //Instance of keychain handler
    private var keychain: KeyChainHandler = KeyChainHandler()
    
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
                    //print("Entered Credentials: \(username), \(password)")
                    let response = try await apiService.postLoginToken(credentials: Credentials(username: username, password: password)) // Call API Service
                    print("Response Token: \(response.loginToken.token)")
                    auth.updateAuthenticationState(true)    // Adjust the authentication state
                    try await keychain.save(response.loginToken.token, forKey: authTokenName)
                } catch {
                    print(error.localizedDescription)
                }
                return
            }
        }
        return 
    }
}
