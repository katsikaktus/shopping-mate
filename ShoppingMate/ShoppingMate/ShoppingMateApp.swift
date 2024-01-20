//
//  ShoppingMateApp.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI
import Firebase

@main
struct ShoppingMateApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured!")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
