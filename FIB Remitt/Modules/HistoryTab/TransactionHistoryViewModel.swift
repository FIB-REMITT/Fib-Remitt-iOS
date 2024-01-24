//
//  TransactionHistoryViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//
import SwiftUI

class TransactionHistoryViewModel : ObservableObject{
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    func navigateToTransactionHistoryDetail() {
       self.destinationView = AnyView(HistoryDetailView())
       self.goToNext        = true
   }
    
    func navigateToEditBankBeneficiary() {
       self.destinationView = AnyView(EditBeneficiaryBankView())
       self.goToNext        = true
   }
}
