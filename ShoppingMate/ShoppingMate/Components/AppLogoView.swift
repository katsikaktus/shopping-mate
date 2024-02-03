//
//  AppLogoView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-04.
//

import SwiftUI

struct AppLogoView: View {
    var body: some View {
        HStack {
            Spacer()
            Image("loginImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(width: 250, height: 150) // Set the desired width and height
                .clipShape(Circle()) // Clip the image into a circle
                .shadow(radius: 1) // Optional: Add a shadow for a nice effec
                .padding(.vertical)
            Spacer()
        }
    }
}

#Preview {
    AppLogoView()
}
