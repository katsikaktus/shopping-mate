//
//  SettingsView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func logout() throws {
        try AuthenticationManager.shared.logout()
    }
    
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task {
                    do {
                        try viewModel.logout()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
                
            }
        }.navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
