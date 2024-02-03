//
//  AuthenticatedUser.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import Foundation
import FirebaseAuth

struct AuthenticatedUser {
    
    let uid: String
    let username: String?
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.username = user.displayName ?? ""
    }
    
}
