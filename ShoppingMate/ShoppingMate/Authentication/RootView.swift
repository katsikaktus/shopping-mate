//
//  RootView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

struct RootView: View {
    
    @State private var showLogInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showLogInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showLogInView = authUser == nil 
        }
        .fullScreenCover(isPresented: $showLogInView, content: {
            NavigationStack{
                AuthenticationView()
            }
        })
    }
}

#Preview {
    RootView()
}
