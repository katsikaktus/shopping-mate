//
//  AuthenticationView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    @State private var isPasswordVisible = false
    @State private var isShowingForgotPasswordSheet = false
    @State private var showError = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom) {
                topBackground
                bottomBackground
                contentScrollView
            }
        }
    }
}

#Preview {
    NavigationStack{
        SignInView()
            .environmentObject(AuthViewModel())
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
    
}

#Preview {
    NavigationStack{
        SignInView()
            .environmentObject(AuthViewModel())
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode")
    }
    
}


extension SignInView{
    
    private var bottomBackground: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.theme.backgroundMainColor)
                .frame(height: 300)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var topBackground: some View {
        VStack {
            Rectangle()
                .fill(Color.theme.backgroundSecondaryColor)
                .frame(height: 500)
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private var contentScrollView: some View {
        ScrollView {
            VStack {
                AppLogoView()
                    .background(Color.theme.backgroundSecondaryColor)
                formView
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: Color.theme.backgroundMainColor, radius: 1, y:-3)
            }
        }
        .padding(.vertical)
    }
    
    
    private var formView: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 16)
            signInTitle
            emailTextField
            passwordTextField
            forgotPasswordPrompt
            Spacer(minLength: 16)
            signInButton
            Spacer(minLength: 40)
            alternativeLoginOptions
            Spacer(minLength: 48)
            signUpPrompt
        }
        .padding(.horizontal, 24)
        .background(Color.theme.backgroundMainColor)
        .sheet(isPresented: $isShowingForgotPasswordSheet) {
            ForgotPasswordView(isShowingForgotPasswordSheet: $isShowingForgotPasswordSheet)
                .presentationDetents([.medium, .large])
        }
        
    }
    
    private var signInTitle: some View {
        Text ("Sign in").font(.title).bold().padding(.horizontal)
        
    }
    
    private var emailTextField: some View {
        TextFieldRowView(
            iconName: "envelope",
            placeholder: "Enter your email",
            text: $email,
            isSecure: false,
            showError: viewModel.didAttemptToProceed && viewModel.emailError != nil,
            errorMessage: viewModel.emailError?.message ?? ""
        )
        .onChange(of: email) { _, newState in
            viewModel.validateEmail(newState)
        }
        .textInputAutocapitalization(.never)
    }
    
    private var passwordTextField: some View {
        ZStack(alignment: .trailing) {
            TextFieldRowView(
                iconName: "lock",
                placeholder: "Enter your password",
                text: $password,
                isSecure: !isPasswordVisible,
                showError: viewModel.didAttemptToProceed && viewModel.passwordError != nil,
                errorMessage: viewModel.passwordError?.message ?? ""
            )
            .onChange(of: password) { _, newState in
                viewModel.validatePassword(newState)
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
    
    private var forgotPasswordPrompt: some View {
        HStack{
            Spacer()
            Button(action: {
                isShowingForgotPasswordSheet = true
            }) {
                Text ("Forgot password?")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundStyle(Color.theme.onBackgroundColor)
            }
            
        }
    }
    
    private var signInButton: some View {
        ButtonComponent(
            buttonText: "Sign in",
            action: {
                viewModel.didAttemptToProceed = true
                viewModel.validateEmail(email)
                viewModel.validatePassword(password)
                if viewModel.isFormValidSignIn {
                    await viewModel.signIn(email: email, password: password) }
            },
            formIsValid: viewModel.isFormValidSignIn
        )
    }
    
    private var alternativeLoginOptions: some View {
        VStack{
            HStack {
                // Left line
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity) // Allow the line to expand
                
                // Text
                Text("or sign in with")
                    .lineLimit(1) // Ensure the text doesn't wrap to multiple lines
                    .fixedSize(horizontal: true, vertical: false) // Fix the size of the text
                
                // Right line
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.theme.onBackgroundColor)
                    .frame(maxWidth: .infinity) // Allow the line to expand
            }
            .frame(height: 12) // Adjust the height as needed
            .padding()
            
            HStack(alignment: .center){
                Spacer()
                Image(systemName: "g.circle.fill")
                    .imageScale(.large)
                    .font(.system(size: 28))
                    .padding(.trailing)
                Image(systemName: "apple.logo")
                    .imageScale(.large)
                    .font(.system(size: 28))
                    .padding(.leading)
                Spacer()
            }
            .foregroundStyle(Color.theme.onBackgroundColor)
        }
    }
    
    private var signUpPrompt: some View {
        HStack(spacing: 3) {
            Spacer()
            Text("Don't have an account ? ")
            NavigationLink {
                SignUpEmailView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Sign up").bold()
                    .foregroundStyle(Color.theme.onBackgroundColor)
            }
            Spacer()
        }.padding()
    }
}
