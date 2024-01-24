//
//  HomeViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI

class HomeViewModel : ObservableObject{
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    
     func navigateSelectBeneficiary() {
        self.destinationView = AnyView(HomeSelectBeneficiaryView())
        self.goToNext        = true
    }
    
    func navigateToBeneficiarySummary() {
       self.destinationView = AnyView(HomeBeneficiarySummaryView())
       self.goToNext        = true
   }
    func navigateToPayViaFIB() {
       self.destinationView = AnyView(HomePayViaFIBView())
       self.goToNext        = true
   }
}
