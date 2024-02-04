//
//  Color.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-04.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let backgroundMainColor = Color("BackgroundMainColor")
    let backgroundSecondaryColor = Color("BackgroundSecondaryColor")
    let errorColor = Color("ErrorColor")
    let onBackgroundColor = Color("OnBackgroundColor")
    let onErrorColor = Color("OnErrorColor")
    let onSecondaryColor = Color("OnSecondaryColor")

    let primaryColor = Color("PrimaryColor")
    let secondaryColor = Color("SecondaryColor")

    
}
