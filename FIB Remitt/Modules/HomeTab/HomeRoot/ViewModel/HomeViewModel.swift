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
    
    @Published var selectedPurpose:PurposeResponse            = PurposeResponse()
    @Published var selectedRecipientCurrency:CurrencyResponse = CurrencyResponse()
    @Published var selectedDeliveryMethod = "Bank Transfer"
    @Published var beneficiaryCollectionResponse:BankCollectionResponse?
    
    @Published var transferAmount = ""
    @Published var recipentAmount = ""
    
    //MARK: - VIEWCONTROLLER LIFICYCLE
    func viewWillAppearCalled() {
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
    
    //MARK: - CUSTOM METHODS
    
    func  storeHomeData() {
        HomeDataHandler.shared.toCurrency       = selectedRecipientCurrency.code ?? ""
        HomeDataHandler.shared.purposeId        = selectedPurpose.id ?? ""
        HomeDataHandler.shared.paymentMethod    = "BANK"
        HomeDataHandler.shared.collectionPoint  = selectedDeliveryMethod == "Bank Transfer" ? "BANK" : "AGENT"
        HomeDataHandler.shared.amountToTransfer = transferAmount
    }
    
    //MARK: - API CALLs
    
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

    func getCurrencies() {
        if HomeDataHandler.shared.purposes.isEmpty{
            repo.getCurrencisAPICall()
            repo.$allCurrency.sink { result in
                HomeDataHandler.shared.currencies = result ?? []
            }.store(in: &subscribers)
        }
    }
    
    func apiReceivedInBank(beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) {
        repo.receivedInBank(beneficiaryId: beneficiaryId, fromCurrency: fromCurrency, amountToTransfer: amountToTransfer, toCurrency: toCurrency, paymentMethod: paymentMethod.uppercased(), collectionPoint: collectionPoint, purposeId: purposeId, invoice: invoice)
            
        repo.$bankCollectionResponse.sink { result in
            print(result)
            if result != nil{
                HomeDataHandler.shared.beneficiaryCollectionResponse = result
                self.navigateToBeneficiarySummary()
            }
            
        }.store(in: &subscribers)
    }
    
    func apiCashPickUpFromAgent(beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) {
        repo.cashPickUpFromAgent(beneficiaryId: beneficiaryId, fromCurrency: fromCurrency, amountToTransfer: amountToTransfer, toCurrency: toCurrency, paymentMethod: paymentMethod, collectionPoint: collectionPoint, purposeId: purposeId, invoice: invoice)
            
        repo.$bankCollectionResponse.sink { result in
            print(result)
            //self.beneficiaryCollectionResponse = result
            
            if result != nil{
                HomeDataHandler.shared.beneficiaryCollectionResponse = result
                self.navigateToBeneficiarySummary()
            }
   
        }.store(in: &subscribers)
    }
    
    func getConfirmationByTransactionId(trxId:String){
        repo.getConfirmation(trxId: trxId)
        repo.$ConfirmationResponse.sink { result in
            print(result)
        }.store(in: &subscribers)
    }
        
}
