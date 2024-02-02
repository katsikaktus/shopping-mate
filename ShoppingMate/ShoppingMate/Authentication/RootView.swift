//
//  RootView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                if !showSignInView {
                    SettingsView(showSignInView: $showSignInView)
                }
                
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil 
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        })
    }
}

#Preview {
    RootView()
}
