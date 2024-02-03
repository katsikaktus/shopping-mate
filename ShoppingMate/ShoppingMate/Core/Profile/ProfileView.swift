//
//  ProfileView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import SwiftUI

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

struct ProfileView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        List{
            Button("Log out"){
                Task {
                    do {
                        try viewModel.logout()
                    } catch {
                        print(error)
                    }
                }
                
            }
            emailSection
            
        }.navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}

extension ProfileView {
    
    private var emailSection: some View {
        Section{
            Button("Reset password"){
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("password RESET")
                    } catch {
                        print(error)
                    }
                }
                
            }
            Button("Update password"){
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("password UPDATED")
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
            Button("Update email"){
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("email UPDATED")
                        
                    } catch {
                        print(error)
                    }
                }
                
            }
        }header: {
            Text("Email functions")
        }
    }
}


