//
//  AuthViewModel.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import Foundation
import Firebase

struct AuthenticatedUser {
    
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
final class AuthViewModel: ObservableObject  {
    
    @Published var userProfile: UserProfile?
    @Published var userFirebaseSession: AuthenticatedUser?
    
    init() {
        print("DEBUG - AuthViewModel init")
        do {
            self.userFirebaseSession = try AuthenticationManager.shared.getAuthenticatedUser()
        } catch {
            print("Error: \(error)")
        }
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(email:String, password: String) async {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        do {
            let authenticatedUser = try await AuthenticationManager.shared.signIn(email: email, password: password)
            self.userFirebaseSession = authenticatedUser
            await fetchUser()
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func signUp(email: String, password: String, username: String) async  {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        do {
            let authenticatedUser = try await AuthenticationManager.shared.createUser(email: email, password: password, username: username)
            
            self.userFirebaseSession = authenticatedUser
            await fetchUser()
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func logout() throws {
        try AuthenticationManager.shared.logout()
        self.userFirebaseSession = nil
        self.userProfile = nil
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
    
    func fetchUser() async {
        self.userProfile = await AuthenticationManager.shared.fetchUser()
    }
}
