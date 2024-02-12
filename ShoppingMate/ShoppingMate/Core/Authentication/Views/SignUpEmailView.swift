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
    @State private var isPasswordVisible = false
    
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
                Spacer(minLength: 56)
                signInPrompt
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            viewModel.didAttemptToSignUp = false
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
            showError: viewModel.didAttemptToSignUp && viewModel.userNameError != FormValidationError.noError,
            errorMessage: viewModel.userNameError?.message)
        .onChange(of: userName) { _, newState in
            viewModel.validateUserName(newState)
        }
    }
    
    private var emailTextField: some View {
        TextFieldRowView(
            iconName: "envelope",
            placeholder: "Enter your email",
            text: $email,
            isSecure: false,
            showError: viewModel.didAttemptToSignUp && viewModel.emailError != FormValidationError.noError,
            errorMessage: viewModel.emailError?.message)
        .textInputAutocapitalization(.never)
        .onChange(of: email) { _, newState in
            viewModel.validateEmail(newState)
        }
    }
    
    private var passwordTextField: some View {
        ZStack(alignment: .trailing) {
            TextFieldRowView(
                iconName: "lock",
                placeholder: "Create your password",
                text: $password,
                isSecure: !isPasswordVisible,
                showError: viewModel.didAttemptToSignUp && viewModel.passwordError != FormValidationError.noError,
                errorMessage: viewModel.passwordError?.message)
            .onChange(of: password) { _, newState in
                viewModel.validatePassword(newState)
                viewModel.validateConfirmPassword(newState, confirmPassword: confirmPassword)
            }
            
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
                showError: viewModel.didAttemptToSignUp && viewModel.confirmPasswordError != FormValidationError.noError,
                errorMessage: viewModel.confirmPasswordError?.message)
            .onChange(of: confirmPassword) { _, newState in
                
                viewModel.validateConfirmPassword(password, confirmPassword: newState)
            }
            
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
                
                viewModel.didAttemptToSignUp = true

                viewModel.validateUserName(userName)
                viewModel.validateEmail(email)
                viewModel.validatePassword(password)
                viewModel.validateConfirmPassword(password, confirmPassword: confirmPassword)
                
                if viewModel.isFormValidSignUp {
                    await viewModel.signUp(email: email, password: password, username: userName)
                } else {
                    
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
