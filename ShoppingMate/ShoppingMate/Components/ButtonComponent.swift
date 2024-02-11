//
//  SignButton.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-04.
//

import SwiftUI

struct ButtonComponent: View {
    let buttonText: String
    let action: () async -> Void
    let formIsValid: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                Task {
                    await action()
                }
            }) {
                Text(buttonText)
                    .font(.headline)
                .foregroundStyle(Color.theme.onSecondaryColor)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.theme.primaryColor)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.3)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 2)
            }
        }
    }
}

