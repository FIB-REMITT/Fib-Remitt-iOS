//
//  HomeViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI
import Combine

class HomeViewModel : ObservableObject{
    private var subscribers         = Set<AnyCancellable>()
    private let repo                = HomeRepository()
    
    @Published var goToNext         = false
    @Published var destinationView  = AnyView(Text("Destination"))
    
    
    //MARK: - VIEWCONTROLLER LIFICYCLE
    func viewWillAppearCalled() {
        self.getNationalities()
        self.getBanks()
        self.getPurposes()
        self.getCurrencies()
    }
    
    //MARK: - NAVIGATIONS
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
    func navigateToSuccessfulView() {
        self.destinationView = AnyView(HomeTransferSuccessfulView())
        self.goToNext        = true
    }
    
    
    
    //MARK: - API CALLs
    func getNationalities() {
        repo.getNationalitiesAPICall()
        repo.$allNationalities.sink { result in
            print(result?.first ?? 0)
        }.store(in: &subscribers)
    }
    
    func getPurposes() {
        repo.getPurposesAPICall()
        repo.$allPurposes.sink { result in
            print(result?.count ?? 0)
        }.store(in: &subscribers)
    }
    
    func getBanks() {
        repo.getBanksAPICall()
        repo.$allBanks.sink { result in
            print(result?.first?.name)
        }.store(in: &subscribers)
    }
    
    func getCurrencies() {
        repo.getCurrencisAPICall()
        repo.$allCurrency.sink { result in
            print(result?.count ?? 0)
        }.store(in: &subscribers)
    }
}
