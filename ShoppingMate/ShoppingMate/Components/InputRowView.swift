//
//  InputRowView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-01-28.
//

import SwiftUI

struct InputRowView: View {
    var iconName: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool

    var body: some View {
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
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 1)
    }
}

#Preview {
    InputRowView(iconName: "envelope", placeholder: "Email...", text: .constant(""), isSecure: false)

}
