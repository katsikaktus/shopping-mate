//
//  AuthenticatedUser.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import Foundation
import FirebaseAuth

struct UserProfile: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
}
