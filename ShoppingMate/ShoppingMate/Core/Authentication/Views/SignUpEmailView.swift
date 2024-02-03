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
                confirmPasswordTextField
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
    SignUpEmailView()
    
}

extension SignUpEmailView{
    
    private var signUpTitle: some View {
        Text ("Create an account").font(.title).bold().padding(.horizontal)
        
    }
    
    private var userNameTextField: some View {
        InputRowView(iconName: "person", placeholder: "Create your username", text: $email, isSecure: false)
    }
    
    private var emailTextField: some View {
        InputRowView(iconName: "envelope", placeholder: "Enter your email", text: $email, isSecure: false)
            .textInputAutocapitalization(.never)
    }
    
    private var passwordTextField: some View {
        InputRowView(iconName: "lock", placeholder: "Create your password", text: $password, isSecure: true)
    }
    
    private var confirmPasswordTextField: some View {
        InputRowView(iconName: "lock", placeholder: "Confirm your password", text: $confirmPassword, isSecure: true)
    }
    
    private var signUpButton: some View {
        HStack{
            Spacer().frame(width: 180)
            // Login Button
            Button(action: {
                // Perform login action here
                Task {
                    await viewModel.signUp(email: email, password: password)
                }
            }) {
                HStack {
                    Text("Sign up")
                        .font(.headline)
                    Image(systemName: "arrow.right") // Arrow icon
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity) // Makes the button wider
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(color: Color.gray, radius: 2, x: 1, y: 1.5)
            }
        }
    }
    
    private var signInPrompt: some View {
        HStack(spacing: 3) {
            Spacer()
            Text("Already have an account ? ")
            Button {
                dismiss()
            } label: {
                Text("Sign in").bold()
            }
            Spacer()
        }.padding()
    }
}
