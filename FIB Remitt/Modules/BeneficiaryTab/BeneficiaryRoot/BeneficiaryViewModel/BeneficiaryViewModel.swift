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
    private let repo        = BeneficiaryRepository()
    private let homeRepo    = HomeRepository()
    @Published var selectedCollectionPoint : CollectionPoint = .all
    
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    
    @Published var allBeneficiaries         : [CommonBeneficiaryModel]?          = []
    @Published var cashPickUpBeneficiaries  : [CashPickupBeneficiariesResponse]? = []
    @Published var bankBeneficiaries        : [BankBeneficiariesResponse]?       = []
    
    //Beneficiary Detail
    @Published var selectedCashPickUpBeneficiary  : CashPickupBeneficiaryDetailResponse?
    @Published var selectedBankBeneficiary        : BankBeneficiariesResponse?
    
    //Beneficiary Create
    @Published var selectedBeneficaryAccountType  : BeneficiaryAccountType = .personal
    @Published var selectedGenderType             : Gender                 = .male
    
    @Published var firstName : String = ""
    @Published var lastName  : String = ""
    @Published var phone     : String = ""
    @Published var address   : String = ""
    //@Published var bankName  : String = ""
    @Published var selectedBankName : String = ""
    @Published var accountNo : String = ""
    @Published var relation : String = ""
    
    //MARK: - VIEWLIFECYCLE
    func viewWillAppearCalled() {
        self.getBankBeneficiaries()
        self.getCashPickBeneficiaries()
        self.getBanks()
        self.getNationalities()
    }
    
    func detailViewOnAppear(beneficiaryType:CollectionPoint) {
        if beneficiaryType == .cash_Pickup{
            self.getCashPickupBeneficiaryDetails()
        }else if beneficiaryType == .bank_Transfer{
            self.getBankBeneficiaryDetails()
        }
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
    func getCashPickBeneficiaries() {
        repo.getCashPickUpBeneficiariesAPICall()
        repo.$allCashPickUpBeneficiaries.sink { result in
            self.cashPickUpBeneficiaries = result
            if result?.count ?? 0 > 0{
                self.getMergedAllBeneficiaries()
            }
        }.store(in: &subscribers)
    }
    
    func getBankBeneficiaries() {
       repo.getBankBeneficiariesAPICall()
       repo.$allBankBeneficiaries.sink { result in
           self.bankBeneficiaries = result
           if result?.count ?? 0 > 0{
               self.getMergedAllBeneficiaries()
           }
       }.store(in: &subscribers)
   }
    
    func getNationalities() {
        if BenficiaryDataHandler.shared.banks.isEmpty{
            homeRepo.getNationalitiesAPICall()
            homeRepo.$allNationalities.sink { result in
                BenficiaryDataHandler.shared.nationalities = result ?? []
            }.store(in: &subscribers)
        }
    }
    
    func getBanks() {
        if BenficiaryDataHandler.shared.banks.isEmpty{
            homeRepo.getBanksAPICall()
            homeRepo.$allBanks.sink { result in
                BenficiaryDataHandler.shared.banks = result ?? []
            }.store(in: &subscribers)
        }
    }
    
    private func getCashPickupBeneficiaryDetails() {
        repo.getCashpickupBeneficiaryDetaisAPICall(id: BenficiaryDataHandler.shared.selectedBenficiaryId)
        repo.$cashpickupBenificiaryById.sink { result in
            if let beneficiary = result{
                self.selectedCashPickUpBeneficiary = beneficiary
            }
        }.store(in: &subscribers)
    }
    
    private func getBankBeneficiaryDetails() {
        repo.getBankBeneficiaryDetaisAPICall(id: BenficiaryDataHandler.shared.selectedBenficiaryId)
        repo.$bankBenificiaryById.sink { result in
            if let beneficiary = result{
                self.selectedBankBeneficiary = beneficiary
            }
        }.store(in: &subscribers)
    }
    
    private func addCashPickupBeneficiary() {
        repo.createCashPickupBeneficiaryAPICall(fullName: "Izak l0", nationality: "87d62a40-2dff-4e98-94b5-a1402cf95179", phone: "+88016785638888", address: "RDuk 90 uhb", gender: "Male", relationShip: "dfghj")
    }
    
    private func addCashPickupBeneficiaryBusiness() {
        repo.createCashPickupBusinessAPICall(fullName: "Izak uu", nationality: "87d62a40-2dff-4e98-94b5-a1402cf95179", phoneNumber: "+88016999938888", address: "DLKFJ dkjf", invoice: loadPDF())
    }
    
    private func addBankBeneficiary() {
        repo.createBankBeneficiaryAPICall(fullName: firstName, nationality: "87d62a40-2dff-4e98-94b5-a1402cf95179", phone: phone, address: address, gender: selectedGenderType.title, relationShip: relation, bankId: "af459441-f577-4c85-8e07-d9245c8c7b45", accNo: "0999584567")
    }
    
    //MARK: - CUSTOME METHODS
    func loadPDF() -> Data? {
        guard let url = Bundle.main.url(forResource: "invoice", withExtension: "pdf") else {
            print("PDF file not found in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error loading PDF data: \(error)")
            return nil
        }
    }
    
    private func getMergedAllBeneficiaries()  {
        self.allBeneficiaries = []
        
        for item in bankBeneficiaries ?? []{
            allBeneficiaries?.append(CommonBeneficiaryModel(id: item.id, title: item.fullName, subTitle: "A/C no: \(item.accountNumber ?? "")", address: item.address,beneficiaryType: .bank_Transfer, accTypeIsBuiessness: item.typeOfBeneficiary  == "Business"))
        }
        
        for item in cashPickUpBeneficiaries ?? []{
            allBeneficiaries?.append(CommonBeneficiaryModel(id: item.id, title: item.fullName, subTitle: "Phone : \(item.phoneNumber ?? "")", address: item.address, beneficiaryType: .cash_Pickup, accTypeIsBuiessness: item.typeOfBeneficiary  == "Business"))
        }
        

    }

}
