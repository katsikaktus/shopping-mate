//
//  SettingsRowView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-04.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text (title)
                .font(.subheadline)
                .foregroundStyle(Color.theme.onBackgroundColor)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "version", tintColor: Color(.systemGray))
}
