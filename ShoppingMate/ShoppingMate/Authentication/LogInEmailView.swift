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
    
    func signIn(){
        //TODO: Add validation steps
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
               let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("DEBUG: Login success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
         
    }
    
}

struct LogInEmailView: View {
    
    @StateObject private var viewModel = LogInEmailViewModel()
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Shopping Mate")
                .font(.title)
                .padding(.top, 120)
                .padding(.horizontal)
            Spacer().frame(height: 60)
            HStack {
                Image(systemName: "envelope") // Icon for the email
                    .foregroundColor(.gray)
                    .frame(width: 28, alignment: .center) // Fixed frame size
                    .padding(.trailing, 8)
                TextField("Email...", text: $viewModel.email)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.gray, radius: 2, x: 1, y: 1.5)
            
            HStack {
                Image(systemName: "lock") // Icon for the password
                    .foregroundColor(.gray)
                    .frame(width: 28, alignment: .center) // Fixed frame size
                    .padding(.trailing, 8)
                SecureField("Password...", text: $viewModel.password)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.gray, radius: 2, x: 1, y: 1.5)
            
            Spacer().frame(height: 60) // Adjust this value to control the space

            HStack{
                Spacer().frame(width: 180)
                // Login Button
                Button(action: {
                    // Perform login action here
                    viewModel.signIn()
                }) {
                    HStack {
                        Text("Login")
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
            Spacer()

            
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack{
        LogInEmailView()
    }
}
