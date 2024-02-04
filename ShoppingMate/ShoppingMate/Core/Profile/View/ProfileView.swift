//
//  ProfileView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import SwiftUI



struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        List{
            userDetails
            emailAndPasswordSection
            accountOptions
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
    
}

#Preview {
    NavigationStack{
        ProfileView()
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode")
    }
    
}

extension ProfileView {
    
    private var userDetails: some View {
        Section {
            HStack {
                Text("KK")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.backgroundSecondaryColor)
                    .frame(width: 72, height: 72)
                    .background(Color.theme.primaryColor)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Katsi Kaktus")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                    Text("katsikaktus@gmail.com")
                        .font(.footnote)
                        .tint(Color.theme.onBackgroundColor)
                }
            }
        }
    }
    
    private var emailAndPasswordSection: some View {
        Section{
            
            Button {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("password UPDATED")
                        
                    } catch {
                        print(error)
                    }
                }
            } label: {
                SettingsRowView(imageName: "lock.shield", title: "Update password", tintColor: Color(.systemGray))
            }

            Button {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("email UPDATED")
                        
                    } catch {
                        print(error)
                    }
                }
                
            }label: {
                SettingsRowView(imageName: "envelope", title: "Update Email", tintColor: Color(.systemGray))
            }
        } header: {
            Text("Email and password")
        }
    }
    
    private var accountOptions: some View {
        Section{
            Button {
                Task {
                    do {
                        try viewModel.logout()
                    } catch {
                        print(error)
                    }
                }
            } label: {
                SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", title: "Log out", tintColor: Color(.systemGray))
            }
            
            Button {
                print("log out...")
            } label: {
                SettingsRowView(imageName: "person.fill.xmark", title: "Delete account", tintColor: Color(.systemGray))
            }

            
        } header: {
            Text("Account options")
        }
    }
}


