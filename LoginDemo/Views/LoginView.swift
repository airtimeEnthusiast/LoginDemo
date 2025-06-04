//
//  LoginView.swift
//  LoginDemo
//
//  Created by Austin Wright on 6/4/25.
//

import SwiftUI

//MARK: Login Page
struct LoginView: View {
    @StateObject var vm: LoginViewModel
    @EnvironmentObject var auth: Authenticator
    
    // Inject auth into the VM
    init(auth: Authenticator) {
        _vm = StateObject(wrappedValue: LoginViewModel(auth: auth))
    }
    
    var body: some View {
        VStack{
            Text("Login".uppercased())
                .font(.system(size: 32, weight: .bold, design: .default))
                .font(.headline)
                .tracking(4)
                .offset(y: -140)
            // Username Field
            LoginField(fieldText: $vm.username, systemImageName: "person", isSecure: false)
                .offset(y: -120)
                .padding()
                .accessibilityIdentifier("username_field")
            // Password Field
            LoginField(fieldText: $vm.password, systemImageName: "lock", isSecure: true)
                .offset(y: -100)
                .padding()
                .accessibilityIdentifier("password_field")
            // Login Button
            Button(action: {
                vm.login()
                
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }.accessibilityIdentifier("login_button")
        }
    }
}

struct LoginField: View {
    @Binding var fieldText: String
    let systemImageName: String
    let isSecure: Bool
    var body: some View {
        VStack{
            HStack {
                Image(systemName: systemImageName)
                    .foregroundColor(.gray)
                if isSecure {
                    SecureField("", text: $fieldText)
                        .foregroundColor(.primary)
                        .autocapitalization(.none)
                }
                else{
                    TextField("", text: $fieldText)
                        .foregroundColor(.primary)
                        .autocapitalization(.none)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

#Preview {
    LoginView(auth: Authenticator())
}
