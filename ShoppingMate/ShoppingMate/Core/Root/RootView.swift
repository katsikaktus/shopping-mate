//
//  RootView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                SignInView()
            }
        }
    }
}

#Preview {
    RootView().environmentObject(AuthViewModel())
}
