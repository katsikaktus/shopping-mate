//
//  ProfileView.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import SwiftUI



struct ProfileView: View {
    
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        List{
            if let _ = viewModel.userProfile {
                userDetails
                emailAndPasswordSection
                accountOptions
            }
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView()
            .environmentObject(AuthViewModel())
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
    
}

#Preview {
    NavigationStack{
        ProfileView()
            .environmentObject(AuthViewModel())
            .preferredColorScheme(.light)
            .previewDisplayName("Light Mode")
    }
    
}

extension ProfileView {
    
    private var userDetails: some View {
        Section {
            HStack {
                Text(viewModel.userProfile?.initials ?? UserProfile.MOCK_USER.initials)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.backgroundSecondaryColor)
                    .frame(width: 72, height: 72)
                    .background(Color.theme.primaryColor)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userProfile?.username ?? UserProfile.MOCK_USER.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                    Text(viewModel.userProfile?.email ?? UserProfile.MOCK_USER.email)
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


