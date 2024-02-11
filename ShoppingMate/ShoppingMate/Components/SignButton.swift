//
//  SignButton.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-04.
//

import SwiftUI

struct SignButton: View {
    let buttonText: String
    let action: () async -> Void
    let iconSystemName: String
    let formIsValid: Bool
    
    var body: some View {
        HStack {
            Spacer().frame(width: 180)
            Button(action: {
                Task {
                    await action()
                }
            }) {
                HStack {
                    Text(buttonText)
                        .font(.headline)
                    Image(systemName: iconSystemName) // Arrow icon
                }
                .foregroundStyle(Color.theme.onSecondaryColor)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.theme.primaryColor)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(radius: 2)
            }
        }
    }
}

