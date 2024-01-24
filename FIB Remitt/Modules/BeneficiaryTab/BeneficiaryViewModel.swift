//
//  BeneficiaryViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI

class BeneficiaryViewModel : ObservableObject{
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    func navigateToBeneficiaryDetail() {
       self.destinationView = AnyView(BeneficiaryDetailView())
       self.goToNext        = true
   }
    
    func navigateToEditBankBeneficiary() {
       self.destinationView = AnyView(EditBeneficiaryBankView())
       self.goToNext        = true
   }
}
