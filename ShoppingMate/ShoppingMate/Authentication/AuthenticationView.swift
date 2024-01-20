//
//  AuthenticationView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-20.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        
        VStack {
            NavigationLink {
                LogInEmailView()
            } label: {
                Text("Login with email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
       
    }
}

#Preview {
    NavigationStack{
        AuthenticationView()
    }
}
