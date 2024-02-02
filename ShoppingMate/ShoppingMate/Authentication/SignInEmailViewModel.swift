//
//  SignInEmailViewModel.swift
//  ShoppingMateTests
//
//  Created by Giota on 2024-02-03.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject  {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return false
        }
        
        do {
            _ = try await AuthenticationManager.shared.logInUser(email: email, password: password)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
}
