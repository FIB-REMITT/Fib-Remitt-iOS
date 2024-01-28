//
//  HomeRepo.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Combine
import SwiftUI

class HomeRepository {
    private var subscribers = Set<AnyCancellable>()
    
    @Published var allNationalities:[NationalityResponse]?
    
    @Published var bankCollectionResponse:BankCollectionResponse?
    
    @Published var ConfirmationResponse : ConfirmationByTransactionResponse?
    
    func getNationalitiesAPICall()  {
        APIManager.shared.getData(endPoint: BasicEndPoint.getNationalities, resultType: [NationalityResponse].self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                
                if result.count > 0{
                        self.allNationalities = result
                       // UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                       // self.vm.successfullyLoggedIn()
                    }

            }.store(in: &subscribers)
    }
    
    @Published var allPurposes:[PurposeResponse]?
    func getPurposesAPICall()  {
        APIManager.shared.getData(endPoint: BasicEndPoint.getPurposes, resultType: [PurposeResponse].self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                
                if result.count > 0{
                        self.allPurposes = result
                       // UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                       // self.vm.successfullyLoggedIn()
                    }

            }.store(in: &subscribers)
    }
    
    @Published var allBanks:[BankResponse]?
    func getBanksAPICall()  {
        APIManager.shared.getData(endPoint: BasicEndPoint.getAllBanks, resultType: [BankResponse].self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                
                if result.count > 0{
                        self.allBanks = result
                       // UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                       // self.vm.successfullyLoggedIn()
                    }

            }.store(in: &subscribers)
    }
    
    @Published var allCurrency:[CurrencyResponse]?
    func getCurrencisAPICall()  {
        APIManager.shared.getData(endPoint: BasicEndPoint.getAllCurrencies, resultType: [CurrencyResponse].self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                
                if result.count > 0{
                        self.allCurrency = result
                       // UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                       // self.vm.successfullyLoggedIn()
                    }

            }.store(in: &subscribers)
    }
    
    func receivedInBank(beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) {
        APIManager.shared.makeAPICallReceivedInBank(isBankbeneficiary:true,beneficiaryId: beneficiaryId, fromCurrency: fromCurrency, amountToTransfer: amountToTransfer, toCurrency: toCurrency, paymentMethod: paymentMethod, collectionPoint: collectionPoint, purposeId: purposeId, invoice: invoice)
          .sink { completion in
            switch completion{
            case .failure(let error):
              if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
               
         
              }else{
             
              }
            case .finished:
             print("finished")
            }
          } receiveValue: { result in
            print(result)
              self.bankCollectionResponse = result
          }.store(in: &subscribers)
      }
    
    
    func cashPickUpFromAgent(beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) {
        APIManager.shared.makeAPICallReceivedInBank(isBankbeneficiary:false,beneficiaryId: beneficiaryId, fromCurrency: fromCurrency, amountToTransfer: amountToTransfer, toCurrency: toCurrency, paymentMethod: paymentMethod, collectionPoint: collectionPoint, purposeId: purposeId, invoice: invoice)
          .sink { completion in
            switch completion{
            case .failure(let error):
              if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
               
         
              }else{
             
              }
            case .finished:
             print("finished")
            }
          } receiveValue: { result in
            print(result)
              self.bankCollectionResponse = result
          }.store(in: &subscribers)
      }
    
    func getConfirmation(trxId:String)  {
        APIManager.shared.getData(endPoint: DashboardEndpoint.confirmationByTrx(trxId: trxId), resultType: ConfirmationByTransactionResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                print(result)
                self.ConfirmationResponse = result

            }.store(in: &subscribers)
    }
    
    
}

