//
//  ForgotPasswordView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-11.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @Binding var isShowingForgotPasswordSheet: Bool
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var showError = false // State to control the error visibility
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text ("Forgot your password?")
                .font(.title)
                .bold()
                .padding()
            
            Text ("Enter your email and we will send you a link to reset it.")
                .font(.subheadline)
                .padding(.horizontal)
            
            TextFieldRowView(iconName: "envelope", placeholder: "Enter your email", text: $email, isSecure: false, showError: showError, errorMessage: errorMessage)
                .padding(.vertical)
            
            ButtonComponent(
                buttonText: "Send link",
                action: {
                    if viewModel.isFormValidResetPassword {
                        try? await viewModel.resetPassword(email: email)
                        isShowingForgotPasswordSheet = false
                    } else {
                        showError = true // Show error if form is not valid
                        errorMessage = "*Please enter a valid email"
                    }
                },
                formIsValid: viewModel.isFormValidResetPassword)
            .padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView(isShowingForgotPasswordSheet: .constant(true))
        .environmentObject(AuthViewModel())
}

