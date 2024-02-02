//
//  SignUpEmailViewModel.swift
//  ShoppingMateTests
//
//  Created by Giota on 2024-02-03.
//

import Foundation

@MainActor
final class SignUpEmailViewModel: ObservableObject  {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return false
        }
        
        do {
            _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
            return true
        } catch {
            print("Error: \(error)")
            return false
        }
    }
 
}
