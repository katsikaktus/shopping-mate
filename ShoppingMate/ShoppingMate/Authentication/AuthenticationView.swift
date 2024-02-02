//
//  AuthenticationView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI




struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            bottomBackground
            contentScrollView
        }
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(true))
    }
}


extension AuthenticationView{
    
    private var bottomBackground: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.white)
                .frame(height: 300)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var contentScrollView: some View {
        ScrollView {
            VStack {
                logoView
                formView
            }
        }
        .padding(.vertical)
    }
    
    private var logoView: some View {
        HStack {
            Spacer()
            Image("loginImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 250, height: 150) // Set the desired width and height
                .clipShape(Circle()) // Clip the image into a circle
                .shadow(radius: 1) // Optional: Add a shadow for a nice effec
                .padding(.vertical)
            Spacer()
        }
    }
    
    private var formView: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 16)
            signInTitle
            emailTextField
            passwordTextField
            forgotPasswordPrompt
            Spacer(minLength: 16)
            logInButton
            Spacer(minLength: 40)
            alternativeLoginOptions
            Spacer(minLength: 60)
            signUpPrompt
        }
        .padding(.horizontal, 24)
        .background(Color.white)
        // Apply background here
    }
    
    private var signInTitle: some View {
        Text ("Sign in").font(.title).bold().padding(.horizontal)
        
    }
    
    private var emailTextField: some View {
        InputRowView(iconName: "envelope", placeholder: "Email...", text: $viewModel.email, isSecure: false)
    }
    
    private var passwordTextField: some View {
        InputRowView(iconName: "lock", placeholder: "Password...", text: $viewModel.password, isSecure: true)
    }
    
    private var forgotPasswordPrompt: some View {
        HStack{
            Spacer()
            Text ("Forgot password?").font(.headline).bold().padding()
        }
    }
    
    private var logInButton: some View {
        HStack{
            Spacer().frame(width: 180)
            Button(action: {
                Task {
                    let isAuthenticated = await viewModel.signIn()
                    if isAuthenticated {
                        showSignInView = false
                    }
                }
            }) {
                HStack {
                    Text("Sign in")
                        .font(.headline)
                    Image(systemName: "arrow.right") // Arrow icon
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(color: Color.gray, radius: 2, x: 1, y: 1.5)
            }
        }
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
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity) // Allow the line to expand
            }
            .frame(height: 20) // Adjust the height as needed
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
            .foregroundStyle(Color.black).opacity(0.7)
        }
    }
    
    private var signUpPrompt: some View {
        HStack() {
            Spacer()
            Text("Don't have an account ? ")
            NavigationLink {
                SignUpEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign up").bold()
            }
            Spacer()
        }.padding()
    }
}
