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
    func login(retryAttempts: Int = 2){
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
                    if retryAttempts == 0 {
                        print("Failed to load user models: \(error)")
                        try? await Task.sleep(1)
                        login(retryAttempts: retryAttempts - 1) // Attempt to make another request
                    }
                }
                return
            }
        }
        return 
    }
}
