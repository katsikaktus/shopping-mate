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
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: username) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension UserProfile {
    static var MOCK_USER = UserProfile(id: NSUUID().uuidString, username: "Katsi Kaktus", email: "kaktus@mail.com")
}
