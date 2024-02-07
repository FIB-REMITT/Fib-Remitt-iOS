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
    
    @Published var selectedPurpose           : PurposeResponse  = PurposeResponse(name: "Select Purpose")
    @Published var selectedRecipientCurrency : CurrencyResponse = CurrencyResponse()
    @Published var selectedDeliveryMethod                       = "Bank Transfer"
    @Published var selectedLanguage              : Language     = .Eng
    @Published var beneficiaryCollectionResponse : BankCollectionResponse?
    @Published var ConfirmationResponse          : ConfirmationByTransactionResponse?
    @Published var PaymentConfirmationResponse   : PaymentCheckResponse?
    
    @Published var transferAmount     = "1"
    @Published var recipentAmount     = "0.0233"
    @Published var isTermsSelected    = false
    @Published var isProceedValidated = false
    
    //MARK: - VIEWCONTROLLER LIFICYCLE
    func viewWillAppearCalled() {
       // HomeDataHandler.shared.clear()
        self.getPurposes()
        self.getCurrencies()
        self.getConversionRates()
    //    self.observeValidationScopes()
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
    
    
    func navigateToSelectBeneficiarySheet() {
        self.destinationView = AnyView(SelectBeneficiaryTypeBottomSheet())
        self.goToNext        = true
    }
    
    func navigateToPayViaFIB() {
        self.destinationView = AnyView(HomePayViaFIBView())
        self.goToNext        = true
    }
    func navigateToSuccessfulView() {
        self.destinationView = AnyView(HomeTransferSuccessfulOrFailedView(isSuccess: true))
        self.goToNext        = true
    }
    
    func navigateToFailedView() {
        self.destinationView = AnyView(HomeTransferSuccessfulOrFailedView(isSuccess: false,trxId: HomeDataHandler.shared.beneficiaryCollectionResponse?.transactionNumber ?? "" ))
        self.goToNext        = true
    }
    
    
    func navigateToFibPAymentCheck(){
        self.destinationView = AnyView(FibPaymentCheckView())
        self.goToNext        = true
    }
    
    
    func navigateToHistoryDetails(trxID:String){
        self.destinationView = AnyView(HistoryDetailView(id: trxID, fromPaymentSuccess: true))
        self.goToNext        = true
    }
    
    
     func navigateToWebAppLink(urlStr:String){
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
//            navigateToFibPAymentCheck()
            UIApplication.shared.open(url)
        }
    }
    
   
    
    //MARK: - CUSTOM METHODS
    func  storeHomeData() {
        HomeDataHandler.shared.toCurrency       = selectedRecipientCurrency.code ?? ""
        HomeDataHandler.shared.purposeId        = selectedPurpose.id ?? ""
        HomeDataHandler.shared.paymentMethod    = "BANK"
        HomeDataHandler.shared.collectionPoint  = selectedDeliveryMethod == "Bank Transfer" ? "BANK" : "AGENT"
        HomeDataHandler.shared.amountToTransfer = transferAmount
    }
    
//    private func observeValidationScopes() {
//        Publishers.CombineLatest($transferAmount, $isTermsSelected)
//            .map { amount, terms in
//                return self.validate(transferAmount: self.transferAmount, termsAndCondition: self.isTermsSelected)
//            }
//            .sink(receiveValue: { isValidate in })
//            .store(in: &subscribers)
//    }
    
    func validateProceedButton() {
        if transferAmount.isEmpty || (Double(transferAmount) == 0){
            self.isProceedValidated = false

        }else if self.isTermsSelected  == false{
            self.isProceedValidated = false

        }else if selectedPurpose.id == nil{
            self.isProceedValidated = false

        }else{
            self.isProceedValidated = true

        }
    }
    
    func convertCurrencyForTransfer(){
        if let conversionRates       = HomeDataHandler.shared.conversionRates{
            let targetRate           = conversionRates.toDictionary()[self.selectedRecipientCurrency.code ?? "TRY"]
            let defaultValue         = transferAmount.isEmpty ? 0.0 : 1.0
            let recipentAmountDouble =  (Double(self.transferAmount) ?? defaultValue) * (targetRate ?? 1.0)
            self.recipentAmount      = String(format: "%.4f", recipentAmountDouble)// "\(recipentAmountDouble)"
        }
    }
    
    func convertCurrencyForRecipient(){
        if let conversionRates       = HomeDataHandler.shared.conversionRates{
            let targetRate           = conversionRates.toDictionary()[self.selectedRecipientCurrency.code ?? "TRY"]
            let defaultValue         = recipentAmount.isEmpty ? 0.0 : 1.0
            let transferAmountDouble =  (Double(self.recipentAmount) ?? defaultValue) / (targetRate ?? 1.0)
            //String(format: "%.4f", myDoubleValue)
            //self.transferAmount      =  "\(Int(transferAmountDouble))"//String(format: "%.4f", transferAmountDouble)
            if transferAmountDouble >= Double(Int.min) && transferAmountDouble <= Double(Int.max) {
                let intValue = Int(transferAmountDouble)
                self.transferAmount      =  "\(intValue)"
                print("Converted value: \(intValue)")
            } else {
                print("Double value is out of the range of Int")
            }
        }
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
                HomeDataHandler.shared.currencies.removeAll { currency in currency.code == "IQD"}
            }.store(in: &subscribers)
        }
    }
    
    func getConversionRates() {
        if HomeDataHandler.shared.conversionRates == nil{
            repo.getConverionRatesAPICall()
            repo.$conversionRates.sink { result in
                HomeDataHandler.shared.conversionRates = result
               self.convertCurrencyForTransfer()
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
            if result != nil{
                self.ConfirmationResponse = result
            }
        }.store(in: &subscribers)
    }
    
    func paymentCheck(trxId:String){
        repo.getPaymentConfirmation(trxId: trxId)
        repo.$PaymentCheckResponseData.sink { result in
            print(result)
            if result != nil{
                self.PaymentConfirmationResponse = result
            }
        }.store(in: &subscribers)
    }
    
    
        
}
