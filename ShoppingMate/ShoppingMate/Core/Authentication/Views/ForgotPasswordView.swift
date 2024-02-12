//
//  ForgotPasswordView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-11.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var email: String
    @Binding var isShowingForgotPasswordSheet: Bool
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text ("Forgot your password?")
                .font(.title)
                .bold()
                .padding()
            
            Text ("Enter your email and we will send you a link to reset it.")
                .font(.subheadline)
                .padding(.horizontal)
            
            TextFieldRowView(
                iconName: "envelope",
                placeholder: email.isEmpty ? "Enter your email" : email,
                text: $email,
                isSecure: false,
                showError: viewModel.didAttemptToResetPassword && viewModel.emailError != FormValidationError.noError,
                errorMessage: viewModel.emailError?.message)
                .onChange(of: email) { _, newState in
                    viewModel.validateEmail(newState)
                }
                .padding(.vertical)
            
            ButtonComponent(
                buttonText: "Send link",
                action: {
                    
                    viewModel.didAttemptToResetPassword = true
                    viewModel.validateEmail(email)
                    if viewModel.isFormValidResetPassword {
                        try? await viewModel.resetPassword(email: email)
                        isShowingForgotPasswordSheet = false
                    }
                },
                formIsValid: viewModel.isFormValidResetPassword)
            .padding(.vertical)
        }.onAppear {
                viewModel.didAttemptToResetPassword = false
         }
        .padding()
    }
}

#Preview {
    ForgotPasswordView(email: .constant("mail@mail.com"), isShowingForgotPasswordSheet: .constant(true))
        .environmentObject(AuthViewModel())
}

