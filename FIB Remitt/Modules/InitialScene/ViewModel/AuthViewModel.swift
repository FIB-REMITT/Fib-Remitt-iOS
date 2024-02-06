//
//  AuthViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI
import Combine

class AuthViewModel : ObservableObject{
    private var subscribers = Set<AnyCancellable>()
    
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    
    let repo = AuthRepository()
    
    func navigateToHome() {
        self.destinationView = AnyView(FRBottomBarContainer())
        self.goToNext        = true
    }
    
    func login() {
//        repo.loginAPICall(username: "amasudul95@gmail.com", pass: "Password100@")
//        repo.$loginInfo.sink { result in
//            if result != nil{
////                self.successfullyLoggedIn()
//            }
//        }.store(in: &subscribers)
    }

    func ssoLogin(code: String){
        repo.ssoLoginAPICall(code: code)
        repo.$authWithFIBResponse.sink{ result in
        }.store(in: &subscribers)
    }
    
    func toWebView(){
        self.destinationView = AnyView(WebContentView())
        self.goToNext        = true
    }
    
    func successfullyLoggedIn() {
        //self.navigateToHome()
    }
    
}
