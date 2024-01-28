//
//  TransactionDetailsViewModel.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import SwiftUI

class TransactionDetailsViewModel : ObservableObject{
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    let repo = TransactionDetailsRepository()
    
    func navigateToTransactionHistoryDetail() {
       //self.destinationView = AnyView(HistoryDetailView())
       self.goToNext        = true
   }
    
    func navigateToEditBankBeneficiary() {
       //self.destinationView = AnyView(EditBeneficiaryBankView())
       self.goToNext        = true
   }
    
    func transactionDetailsFetch(transactionNumber: String) {
            repo.transactionDetailsApi(transactionNumber: transactionNumber)
        }
}
