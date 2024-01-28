//
//  SignInEmailView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

@MainActor
final class LogInEmailViewModel: ObservableObject  {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        //TODO: Add validation steps
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        //TODO: Add validation steps
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        _ = try await AuthenticationManager.shared.logInUser(email: email, password: password)
    }
    
    
    
}

struct LogInEmailView: View {
    
    @StateObject private var viewModel = LogInEmailViewModel()
    
    @Binding var showLogInView: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                appLogo
                Spacer().frame(height: 32)
                emailTextField
                passwordTextField
                Spacer().frame(height: 32)
                logInButton
                Spacer().frame(height: 32)
                signUpPrompt
                alternativeLoginOptions
                Image("loginImage")
                    .resizable()
                    .scaledToFit()
                Spacer()
                
                
            }
            .padding(.horizontal, 24)
        }
        
    }
}

#Preview {
    NavigationStack{
        LogInEmailView(showLogInView: .constant(false))
    }
}

extension LogInEmailView{
    
    private var appLogo: some View {
        Text("Shopping Mate")
            .font(.title)
            .padding(.top, 40)
            .padding(.horizontal)
    }
    
    private var emailTextField: some View {
        InputRowView(iconName: "envelope", placeholder: "Email...", text: $viewModel.email, isSecure: false)
    }
    
    private var passwordTextField: some View {
        InputRowView(iconName: "lock", placeholder: "Password...", text: $viewModel.password, isSecure: true)
    }
    
    private var logInButton: some View {
        HStack{
            Spacer().frame(width: 180)
            // Login Button
            Button(action: {
                // Perform login action here
                Task {
                    do {
                        try await viewModel.signUp()
                        showLogInView = false
                        return
                    } catch {
                        print("Error: \(error)")
                    }
                    do {
                        try await viewModel.signIn()
                        showLogInView = false
                    } catch {
                        print("Error: \(error)")
                    }
                }

            }) {
                HStack {
                    Text("Log in")
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
    
    private var signUpPrompt: some View {
        HStack() {
            Spacer()
            Text("Don't have an account ? ")
            Text("Sign up").bold()
            Spacer()
        }.padding()
    }
    
    private var alternativeLoginOptions: some View {
        VStack{
            HStack {
                // Left line
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                // Text
                Text("or log in with")
                
                // Right line
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
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
        

}
