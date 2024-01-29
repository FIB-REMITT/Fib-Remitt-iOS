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
    
    @Published var selectedPurpose:PurposeResponse = PurposeResponse()
    
    
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
        if HomeDataHandler.shared.purposes.isEmpty{
            repo.getPurposesAPICall()
            repo.$allPurposes.sink { result in
                if result?.count ?? 0 > 0 {
                    HomeDataHandler.shared.purposes = result ?? []
                }
            }.store(in: &subscribers)
        }
    }
    
    func getBanks() {
        repo.getBanksAPICall()
        repo.$allBanks.sink { result in
            
        }.store(in: &subscribers)
    }
    
    func getCurrencies() {
        repo.getCurrencisAPICall()
        repo.$allCurrency.sink { result in
            print(result?.count ?? 0)
        }.store(in: &subscribers)
    }
    
    func apiReceivedInBank(beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) {
        repo.receivedInBank(beneficiaryId: beneficiaryId, fromCurrency: fromCurrency, amountToTransfer: amountToTransfer, toCurrency: toCurrency, paymentMethod: paymentMethod, collectionPoint: collectionPoint, purposeId: purposeId, invoice: invoice)
            
        repo.$bankCollectionResponse.sink { result in
            print(result)
            
        }.store(in: &subscribers)
    }
    
    func cashPickUpFromAgent(beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) {
        repo.receivedInBank(beneficiaryId: beneficiaryId, fromCurrency: fromCurrency, amountToTransfer: amountToTransfer, toCurrency: toCurrency, paymentMethod: paymentMethod, collectionPoint: collectionPoint, purposeId: purposeId, invoice: invoice)
            
        repo.$bankCollectionResponse.sink { result in
            print(result)
            
        }.store(in: &subscribers)
    }
    
    func getConfirmationByTransactionId(trxId:String){
        repo.getConfirmation(trxId: trxId)
        repo.$ConfirmationResponse.sink { result in
            print(result)
        }.store(in: &subscribers)
    }
        
}
