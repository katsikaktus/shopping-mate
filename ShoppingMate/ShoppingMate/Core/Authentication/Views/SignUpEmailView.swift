//
//  SignInEmailView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI


struct SignUpEmailView: View {
    @State var email = ""
    @State var password = ""
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 150)
            
            VStack(alignment:.leading) {
                Spacer(minLength: 32)
                signUpTitle
                emailTextField
                passwordTextField
                Spacer(minLength: 32)
                signUpButton
                Spacer(minLength: 32)
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
        Text ("Sign up").font(.title).bold().padding(.horizontal)
        
    }
    
    private var emailTextField: some View {
        InputRowView(iconName: "envelope", placeholder: "Email...", text: $email, isSecure: false)
    }
    
    private var passwordTextField: some View {
        InputRowView(iconName: "lock", placeholder: "Password...", text: $password, isSecure: true)
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
        HStack() {
            Spacer()
            Text("Already have an account ? ")
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Sign in").bold()
            }
            Spacer()
        }.padding()
    }
}
