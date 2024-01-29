//
//  BeneficiaryViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI
import Combine

class BeneficiaryViewModel : ObservableObject{
    private var subscribers = Set<AnyCancellable>()
    private let repo = BeneficiaryRepository()
    
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    //MARK: - VIEWLIFECYCLE
    func viewWillAppearCalled() {
//        self.getBankBeneficiaryDetails()
//        self.getCashPickupBeneficiaryDetails()
//        self.addBankBeneficiary()
    }
    
    //MARK: - NAVIGATION
    func navigateToBeneficiaryDetail() {
       self.destinationView = AnyView(BeneficiaryDetailView())
       self.goToNext        = true
   }
    
    func navigateToEditBankBeneficiary() {
       self.destinationView = AnyView(EditBeneficiaryBankView())
       self.goToNext        = true
   }
    
    //MARK: - API CALL
   private func getCashPickBeneficiaries() {
        repo.getCashPickUpBeneficiariesAPICall()
        repo.$allCashPickUpBeneficiaries.sink { result in
            print(result?.first ?? 0)
        }.store(in: &subscribers)
    }
    
    private func getCashPickupBeneficiaryDetails() {
        repo.getCashpickupBeneficiaryDetaisAPICall(id: "69b32b4c-c66b-4daa-9814-26e8efa5a499" )
        repo.$cashpickupBenificiaryById.sink { result in
            print(result?.phoneNumber ?? "0")
        }.store(in: &subscribers)
    }
    
    private func getBankBeneficiaries() {
        repo.getBankBeneficiariesAPICall()
        repo.$allBankBeneficiaries.sink { result in
            print(result?.first ?? 0)
        }.store(in: &subscribers)
    }
    
    private func getBankBeneficiaryDetails() {
        repo.getBankBeneficiaryDetaisAPICall(id: "57d1c26a-37d1-4f16-ac42-bb90aea13573" )
        repo.$bankBenificiaryById.sink { result in
            print(result?.accountNumber ?? "0")
        }.store(in: &subscribers)
    }
    
    private func addCashPickupBeneficiary() {
        repo.createCashPickupBeneficiaryAPICall(fullName: "Izak l0", nationality: "87d62a40-2dff-4e98-94b5-a1402cf95179", phone: "+88016785638888", address: "RDuk 90 uhb", gender: "Male", relationShip: "dfghj")
    }
    
    private func addBankBeneficiary() {
        repo.createBankBeneficiaryAPICall(fullName: "Izak l0", nationality: "87d62a40-2dff-4e98-94b5-a1402cf95179", phone: "+88016785638888", address: "RDuk 90 uhb", gender: "Male", relationShip: "dfghj", bankId: "af459441-f577-4c85-8e07-d9245c8c7b45", accNo: "0999584567")
    }

}
