//
//  InputRowView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-28.
//

import SwiftUI

struct TextFieldRowView: View {
    var iconName: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool
    var showError: Bool // Indicates whether to show the error state
    var errorMessage: String? // The error message to display
    
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(Color.theme.onBackgroundColor)
                    .frame(width: 28, alignment: .center)
                    .padding(.trailing, 8)
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding()
            .background(Color.theme.backgroundSecondaryColor)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(!showError ? Color.gray : Color.theme.errorColor, lineWidth: 0.5))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 1)
            
            HStack {
                Spacer()
                Text(errorMessage ?? "")
                    .font(.caption)
                    .foregroundColor(Color.theme.errorColor)
                    .padding(.horizontal)
                    .opacity(showError ? 1 : 0) // Fully visible when there's an error, otherwise invisible
            }
        }
    }
}

#Preview {
    
    TextFieldRowView(iconName: "envelope", placeholder: "Email...", text: .constant(""), isSecure: false, showError: true, errorMessage: "*Please enter a valid email")
    
}
