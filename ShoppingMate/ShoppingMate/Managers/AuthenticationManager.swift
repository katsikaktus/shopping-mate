//
//  AuthenticationManager.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    // Get value from the local SDK
    func getAuthenticatedUser() throws -> AuthenticatedUser {
        guard let user = Auth.auth().currentUser else {
            // TODO - update with custom error
            throw URLError(.badServerResponse)
        }
        return AuthenticatedUser(user: user)
    }
    
    // Once the user is authenticated, they are saved on the SDK locally
    @discardableResult
    func createUser(email: String, password: String, username: String) async throws -> AuthenticatedUser {
        
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        print("DEBUG: Manager authDataResult", authDataResult )
        
        let userProfile = UserProfile(id: authDataResult.user.uid, username: username, email: email)
        print("DEBUG: Manager userProfile", userProfile )
        
        
        let encodedUser = try Firestore.Encoder().encode(userProfile)
        try await Firestore.firestore().collection("users").document(userProfile.id).setData(encodedUser)
        print("DEBUG: Manager")
        return AuthenticatedUser(user: authDataResult.user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthenticatedUser {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthenticatedUser(user: authDataResult.user)
    }
    
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.sendEmailVerification()
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func fetchUser() async -> UserProfile? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        do {
            // Attempt to fetch the document for the user
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            // Attempt to decode the document snapshot into a UserProfile object
            let userProfile = try snapshot.data(as: UserProfile.self)
            print("DEBUG: Manager userProfile", userProfile )

            return userProfile
        } catch {
            // Handle or log any errors that occur
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }
    
}
