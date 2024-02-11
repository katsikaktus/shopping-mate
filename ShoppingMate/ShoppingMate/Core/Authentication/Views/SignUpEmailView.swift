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
    @State private var showError = false
    @State private var isPasswordVisible = false
    @State private var errorMessage = ""
    
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
                Spacer(minLength: 80)
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
        TextFieldRowView(
            iconName: "person",
            placeholder: "Create your username",
            text: $userName,
            isSecure: false,
            showError: viewModel.userNameError != nil,
            errorMessage: viewModel.userNameError?.message ?? "")
    }
    
    private var emailTextField: some View {
        TextFieldRowView(
            iconName: "envelope",
            placeholder: "Enter your email",
            text: $email,
            isSecure: false,
            showError: viewModel.emailError != nil,
            errorMessage: viewModel.emailError?.message ?? "")
        .textInputAutocapitalization(.never)
    }
    
    private var passwordTextField: some View {
        ZStack(alignment: .trailing) {
            TextFieldRowView(
                iconName: "lock",
                placeholder: "Create your password",
                text: $password,
                isSecure: !isPasswordVisible,
                showError: viewModel.passwordError != nil,
                errorMessage: viewModel.passwordError?.message ?? "")
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                    .padding(.bottom)
            }
        }
        
    }
    
    private var confirmPasswordTextField: some View {
        ZStack(alignment: .trailing) {
            TextFieldRowView(
                iconName: "lock",
                placeholder: "Confirm your password",
                text: $confirmPassword,
                isSecure: !isPasswordVisible,
                showError: viewModel.confirmPasswordError != nil,
                errorMessage: viewModel.confirmPasswordError?.message ?? "")
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                    .padding(.bottom)
            }
        }
    }
    
    private var signUpButton: some View {
        ButtonComponent(
            buttonText: "Sign up",
            action: {
                viewModel.validateUserName(userName)
                viewModel.validateEmail(email)
                viewModel.validatePassword(password)
                viewModel.validateConfirmPassword(password, confirmPassword: confirmPassword)
                
                if viewModel.isFormValidSignUp {
                    await viewModel.signUp(email: email, password: password, username: userName)
                }
            },
            formIsValid: viewModel.isFormValidSignUp
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
