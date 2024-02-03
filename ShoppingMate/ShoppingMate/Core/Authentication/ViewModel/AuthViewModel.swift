//
//  AuthViewModel.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import Foundation
import Firebase

@MainActor
final class AuthViewModel: ObservableObject  {
    
    @Published var currentUser: AuthenticatedUser?
    
    init() {
        self.currentUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signIn(email:String, password: String) async {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        do {
            let authenticatedUser = try await AuthenticationManager.shared.signIn(email: email, password: password)
            self.currentUser = authenticatedUser

        } catch {
            print("Error: \(error)")
        }
    }
    
    func signUp(email:String, password: String) async  {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        do {
            let authenticatedUser = try await AuthenticationManager.shared.createUser(email: email, password: password)
            self.currentUser = authenticatedUser
        } catch {
            print("Error: \(error)")
        }
    }
}
