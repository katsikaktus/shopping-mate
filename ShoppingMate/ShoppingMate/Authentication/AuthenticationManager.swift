//
//  AuthenticationManager.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    // Get value from the local SDK
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    // Once the user is authenticated, they are saved on the SDK locally
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
       let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
}
