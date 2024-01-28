//
//  AuthViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI
import Combine

class AuthViewModel : ObservableObject{
    @Published var goToNext = false
    @Published var tapped  = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    
    let repo = AuthRepository()
    
    private func navigateToHome() {
        self.destinationView = AnyView(FRBottomBarContainer())
        self.goToNext        = true
    }
    
    func login() {
        repo.loginAPICall(username: "amasudul95@gmail.com", pass: "Password100@")
    }
    
    func successfullyLoggedIn() {
       // navigateToHome()
        tapped = true
    }
}
