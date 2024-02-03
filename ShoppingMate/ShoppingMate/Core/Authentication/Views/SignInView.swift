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
    @EnvironmentObject var viewModel: AuthViewModel
        
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom) {
                bottomBackground
                contentScrollView
            }
        }
    }
}

#Preview {
    SignInView()
}


extension SignInView{
    
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
                AppLogoView()
                formView
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
        .background(Color.white)
        // Apply background here
    }
    
    private var signInTitle: some View {
        Text ("Sign in").font(.title).bold().padding(.horizontal)
        
    }
    
    private var emailTextField: some View {
        InputRowView(iconName: "envelope", placeholder: "Enter your email", text: $email, isSecure: false)
            .textInputAutocapitalization(.never)
    }
    
    private var passwordTextField: some View {
        InputRowView(iconName: "lock", placeholder: "Enter your password", text: $password, isSecure: true)
    }
    
    private var forgotPasswordPrompt: some View {
        HStack{
            Spacer()
            Text ("Forgot password?").font(.headline).bold().padding()
        }
    }
    
    private var signInButton: some View {
        HStack{
            Spacer().frame(width: 180)
            Button(action: {
                Task {
                    await viewModel.signIn(email: email, password: password)
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
                SignUpEmailView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Sign up").bold()
            }
            Spacer()
        }.padding()
    }
}
