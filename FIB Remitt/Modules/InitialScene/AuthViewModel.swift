//
//  AuthViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI

class AuthViewModel : ObservableObject{
    @Published var goToNext = false
    @Published var destinationView = AnyView(Text("Destination"))
    
     func navigateToHome() {
        self.destinationView = AnyView(FRBottomBarContainer())
        self.goToNext        = true
    }
}
