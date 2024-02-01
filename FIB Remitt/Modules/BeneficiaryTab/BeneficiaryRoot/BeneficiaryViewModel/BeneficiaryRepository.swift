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
    
    @Published var cashPickupBeneficiaryNormalCreationStatus:Bool?
    func createCashPickupBeneficiaryAPICall(fullName:String, nationality:String, phone:String, address:String, gender:String, relationShip:String)  {
        APIManager.shared.uploadFormData(endPoint: BeneficiaryEndpoint.createCashPickupPersonalBeneficiary(fullName: fullName, nationality: nationality, phoneNumber: phone, address: address, gender: gender, relationShip: relationShip), resultType: EmptyResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
                        print("Successfully Created CashPickup Beneficiary")
                        self.cashPickupBeneficiaryNormalCreationStatus = true
                        showToast( message: "Account Created Successfully!",after: 0.2)
                        loadView(view: FRBottomBarContainer(selected: TabBarItem(icon: "beneficiary_ico", title: "Beneficiary", color: .red)))
                    }else{
                        print("Failed!")
                        self.cashPickupBeneficiaryNormalCreationStatus = false
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
                        showToast( message: "Account Created Successfully!",after: 0.2)
                        loadView(view: FRBottomBarContainer(selected: TabBarItem(icon: "beneficiary_ico", title: "Beneficiary", color: .red)))
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
    
    @Published var cashPickupBeneficiaryBusinessCreationStatus:Bool?
    func createCashPickupBusinessAPICall(fullName:String, nationality:String, phoneNumber:String, address:String, invoice:Data?) {
        APIManager.shared.uploadPdfDocs(endPoint: BeneficiaryEndpoint.createCashPickupBusinessBeneficiary(fullName: fullName, nationality: nationality, phoneNumber: phoneNumber, address: address), invoice: invoice, resultType:  EmptyResponse.self, showLoader: true)
          .sink { completion in
            switch completion{
            case .failure(let error):
              if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
                  print("Successfully Created CashPickup Beneficiary Business")
                  self.cashPickupBeneficiaryBusinessCreationStatus = true
                  showToast( message: "Account Created Successfully!",after: 0.2)
                  loadView(view: FRBottomBarContainer(selected: TabBarItem(icon: "beneficiary_ico", title: "Beneficiary", color: .red)))
              }else{
                  print("Failed!")
                  self.cashPickupBeneficiaryBusinessCreationStatus = false
              }
            case .finished:
                print("API Called!")
            }
          } receiveValue: { result in
            print(result)
          }.store(in: &subscribers)
      }
    
    @Published var bankBeneficiaryBusinessCreationStatus:Bool?
    func createBankBeneficiaryBusinessAPICall(fullName:String, nationality:String, phone:String, address:String, bankId:String, accNo:String, invoice:Data?)  {
        APIManager.shared.uploadPdfDocs(endPoint: BeneficiaryEndpoint.createBankBusinessBeneficiary(fullName: fullName, nationality: nationality, phoneNumber: phone, address: address, bankId: bankId, accNo: accNo), invoice: invoice, resultType: EmptyResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if error.localizedDescription == NetworkError.responseIsEmpty.localizedDescription{
                        print("Successfully Created Bank Beneficiary Business type")
                        self.bankBeneficiaryNormalCreationStatus = true
                        showToast( message: "Account Created Successfully!",after: 0.2)
                        loadView(view: FRBottomBarContainer(selected: TabBarItem(icon: "beneficiary_ico", title: "Beneficiary", color: .red)))
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
    
}
