//
//  ProfileViewModel.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-04.
//

import Foundation


@MainActor
final class ProfileViewModel: ObservableObject {
    
    func logout() throws {
        try AuthenticationManager.shared.logout()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let password = "Hello123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        try await AuthenticationManager.shared.updateEmail()
    }
}
