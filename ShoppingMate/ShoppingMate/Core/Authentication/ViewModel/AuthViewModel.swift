//
//  AuthViewModel.swift
//  ShoppingMate
//
//  Created by Giota on 2024-02-03.
//

import Foundation
import Firebase

struct AuthenticatedUser {
    
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}


@MainActor
final class AuthViewModel: ObservableObject  {
    
    @Published var userProfile: UserProfile?
    @Published var currentUser: AuthenticatedUser?

    @Published var userNameError: FormValidationError? = .emptyUserName
    @Published var emailError: FormValidationError? = .invalidEmail
    @Published var passwordError: FormValidationError? = .passwordTooWeak
    @Published var confirmPasswordError: FormValidationError? = .passwordsDoNotMatch
    
    @Published var didAttemptToSignIn = false
    @Published var didAttemptToSignUp = false
    @Published var didAttemptToResetPassword = false



    
    init() {
        print("DEBUG - AuthViewModel init")
        do {
            self.currentUser = try AuthenticationManager.shared.getAuthenticatedUser()
        } catch {
            print("AuthViewModel init - no current user \(error)")
        }
        
        Task {
            await fetchUser()
        }
    }
    
    // MARK: Validation methods
    func validateUserName(_ userName: String) {
        if userName.isEmpty {
            userNameError = .emptyUserName
        } else {
            userNameError = .noError
        }
    }
    
    func validateEmail(_ email: String) {
        // Define a character set containing all valid characters for an email address
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.-_")
        
        // Check if the email contains only allowed characters
        let emailCharacterSet = CharacterSet(charactersIn: email)
        if email.isEmpty {
            emailError = .invalidEmail
        } else if !email.contains("@") || !email.contains(".") {
            emailError = .invalidEmail
        } else if !emailCharacterSet.isSubset(of: allowedCharacterSet) {
            // If the email contains characters not found in the allowed character set, it's invalid
            emailError = .invalidEmail
        } else {
            emailError = .noError
        }
    }
    
    func validatePassword(_ password: String) {
        if password.count < 6 {
            passwordError = .passwordTooWeak
        } else {
            passwordError = .noError
        }
    }
    
    func validateConfirmPassword(_ password: String, confirmPassword: String) {
        if confirmPassword != password {
            confirmPasswordError = .passwordsDoNotMatch
        } else {
            confirmPasswordError = .noError
        }
    }
    
    var isFormValidResetPassword: Bool {
        emailError == .noError
    }
    
    var isFormValidSignIn: Bool {
        emailError == .noError
        && passwordError == .noError
    }
    
    var isFormValidSignUp: Bool {
        userNameError == .noError
        && emailError == .noError
        && passwordError == .noError
        && confirmPasswordError == .noError
    }
    
    
    

    // MARK: Authentication functions
    func signIn(email:String, password: String) async {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        do {
            let authenticatedUser = try await AuthenticationManager.shared.signIn(email: email, password: password)
            self.currentUser = authenticatedUser
            await fetchUser()
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func signUp(email: String, password: String, username: String) async  {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        do {
            let authenticatedUser = try await AuthenticationManager.shared.createUser(email: email, password: password, username: username)
            
            self.currentUser = authenticatedUser
            await fetchUser()
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func logout() throws {
        try AuthenticationManager.shared.logout()
        self.currentUser = nil
        self.userProfile = nil
    }
    
    func resetPassword(email: String) async throws {
        /*let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
         
         guard let email = authUser.email else {
         throw URLError(.fileDoesNotExist)
         }*/
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let password = "Hello123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        try await AuthenticationManager.shared.updateEmail()
    }
    
    func fetchUser() async {
        self.userProfile = await AuthenticationManager.shared.fetchUser()
    }
    
    
}

enum FormValidationError: Error, Equatable {
    
    var id: String { self.message }
    case noError
    case emptyUserName
    case invalidEmail
    case passwordTooWeak
    case passwordsDoNotMatch
    case custom(message: String)
    
    var message: String {
        switch self {
        case .emptyUserName:
            return "*Please enter a username."
        case .invalidEmail:
            return "*Please enter a valid email format."
        case .passwordTooWeak:
            return "*Password must be at least 6 characters long."
        case .passwordsDoNotMatch:
            return "*Passwords do not match."
        case .noError:
            return "No error"
        case .custom(let message):
            return message
        }
    }
}

