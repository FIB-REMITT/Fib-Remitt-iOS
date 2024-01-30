//
//  BeneficiaryRepository.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Combine
import Foundation

class BeneficiaryRepository {
    private var subscribers = Set<AnyCancellable>()
    
    @Published var allCashPickUpBeneficiaries:[CashPickupBeneficiariesResponse]?
    func getCashPickUpBeneficiariesAPICall()  {
        APIManager.shared.getData(endPoint: BeneficiaryEndpoint.getCashPickupBeneficiaries, resultType: [CashPickupBeneficiariesResponse].self, showLoader: true)
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
                    self.allCashPickUpBeneficiaries = result
                }
                
            }.store(in: &subscribers)
    }
    
    @Published var allBankBeneficiaries:[BankBeneficiariesResponse]?
    func getBankBeneficiariesAPICall()  {
        APIManager.shared.getData(endPoint: BeneficiaryEndpoint.getBankBeneficiaries, resultType: [BankBeneficiariesResponse].self, showLoader: true)
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
                    self.allBankBeneficiaries = result
                }
                
            }.store(in: &subscribers)
    }
    
    @Published var bankBenificiaryById:BankBeneficiariesResponse?
    func getBankBeneficiaryDetaisAPICall(id:String)  {
        APIManager.shared.getData(endPoint: BeneficiaryEndpoint.getBankDetails(id: id), resultType: BankBeneficiariesResponse.self, showLoader: true)
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
                self.bankBenificiaryById = result
            }.store(in: &subscribers)
    }
    
    @Published var cashpickupBenificiaryById:CashPickupBeneficiaryDetailResponse?
    func getCashpickupBeneficiaryDetaisAPICall(id:String)  {
        APIManager.shared.getData(endPoint: BeneficiaryEndpoint.getCashPickupDetails(id: id), resultType: CashPickupBeneficiaryDetailResponse.self, showLoader: true)
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
                self.cashpickupBenificiaryById = result
            }.store(in: &subscribers)
    }
    
    func createCashPickupBeneficiaryAPICall(fullName:String, nationality:String, phone:String, address:String, gender:String, relationShip:String)  {
        APIManager.shared.uploadFormData(endPoint: BeneficiaryEndpoint.createCashPickupPersonalBeneficiary(fullName: fullName, nationality: nationality, phoneNumber: phone, address: address, gender: gender, relationShip: relationShip), resultType: EmptyResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
                        print("Successfully Created CashPickup Beneficiary")
                    }else{
                        print("Failed!")
                    }
                    
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
            }.store(in: &subscribers)
    }
    
    @Published var bankBeneficiaryNormalCreationStatus:Bool?
    func createBankBeneficiaryAPICall(fullName:String, nationality:String, phone:String, address:String, gender:String, relationShip:String, bankId:String, accNo:String)  {
        APIManager.shared.uploadFormData(endPoint: BeneficiaryEndpoint.createBankPersonalBeneficiary(fullName: fullName, nationality: nationality, phoneNumber: phone, address: address, gender: gender, relationShip: relationShip, bankId: bankId, accNo: accNo), resultType: EmptyResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
                        print("Successfully Created CashPickup Beneficiary")
                        self.bankBeneficiaryNormalCreationStatus = true
                    }else{
                        self.bankBeneficiaryNormalCreationStatus = false
                        print("Failed!")
                    }
                    
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
            }.store(in: &subscribers)
    }
    
    func createCashPickupBusinessAPICall(fullName:String, nationality:String, phoneNumber:String, address:String, invoice:Data?) {
        APIManager.shared.uploadBeneficiaryDocs(fullName: fullName, nationalityId: nationality, phoneNumber: phoneNumber, address: address, invoice: invoice)
          .sink { completion in
            switch completion{
            case .failure(let error):
              if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
                  print("Successfully Created CashPickup Beneficiary")
              }else{
                  print("Failed!")
              }
            case .finished:
                print("API Called!")
            }
          } receiveValue: { result in
            print(result)
          }.store(in: &subscribers)
      }
}
