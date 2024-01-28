//
//  TransactionListViewModel.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import SwiftUI
import Combine

class TransactionListViewModel : ObservableObject{
    @Published var goToNext = false
    @Published var tapped  = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    
    let repo = TransactionListRepository()
    
    private func navigateToHome() {
       // self.destinationView = AnyView(FRBottomBarContainer())
        self.goToNext        = true
    }
    
    func transactionListFetch() {
        repo.transactionListApi()
    }
//    
//    func successfullyLoggedIn() {
//       // navigateToHome()
//        tapped = true
//    }
}
