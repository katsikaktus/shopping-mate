//
//  SignInEmailView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI


struct SignUpEmailView: View {
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            AppLogoView()
  
            VStack(alignment:.leading) {
                Spacer(minLength: 16)
                signUpTitle
                userNameTextField
                emailTextField
                passwordTextField
                
                ZStack(alignment: .trailing) {
                    confirmPasswordTextField
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                                .padding()
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGray))
                                .padding()
                        }
                    }
                }
                
                Spacer(minLength: 40)
                signUpButton
                Spacer(minLength: 116)
                signInPrompt
            }
            .padding(.horizontal, 24)
        }
        
    }
}

#Preview {
    SignUpEmailView().environmentObject(AuthViewModel())
    
}

extension SignUpEmailView{
    
    private var signUpTitle: some View {
        Text ("Create an account").font(.title).bold().padding(.horizontal)
        
    }
    
    private var userNameTextField: some View {
        TextFieldRowView(iconName: "person", placeholder: "Create your username", text: $userName, isSecure: false)
    }
    
    private var emailTextField: some View {
        TextFieldRowView(iconName: "envelope", placeholder: "Enter your email", text: $email, isSecure: false)
            .textInputAutocapitalization(.never)
    }
    
    private var passwordTextField: some View {
        TextFieldRowView(iconName: "lock", placeholder: "Create your password", text: $password, isSecure: true)
    }
    
    private var confirmPasswordTextField: some View {
        TextFieldRowView(iconName: "lock", placeholder: "Confirm your password", text: $confirmPassword, isSecure: true)
    }
    
    private var signUpButton: some View {
        SignButton(
            buttonText: "Sign up",
            action: { await viewModel.signUp(email: email, password: password, username: userName) },
            iconSystemName: "arrow.right", formIsValid: formIsValid
        )
    }
    
    private var signInPrompt: some View {
        HStack(spacing: 3) {
            Spacer()
            Text("Already have an account ? ")
            Button {
                dismiss()
            } label: {
                Text("Sign in").bold()
                    .foregroundStyle(Color.theme.onBackgroundColor)
            }
            Spacer()
        }.padding()
    }
}

extension SignUpEmailView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !userName.isEmpty
    }
}
