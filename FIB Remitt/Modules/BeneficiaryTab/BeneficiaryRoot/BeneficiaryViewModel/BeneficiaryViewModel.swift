//
//  BeneficiaryViewModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI
import Combine

class BeneficiaryViewModel : ObservableObject{
    private var subscribers     = Set<AnyCancellable>()
    private let repo            = BeneficiaryRepository()
    private let homeRepo        = HomeRepository()
    private let beneficiaryData = BenficiaryDataHandler.shared
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
    
    @Published var firstName : String                         = ""
    //@Published var lastName  : String                       = ""
    @Published var phone     : String                         = ""
    @Published var address   : String                         = ""
    //@Published var bankName  : String                       = ""
    @Published var selectedBankName     : BankResponse        = BankResponse(name: "Select Bank")
    @Published var selectedNationality  : NationalityResponse = NationalityResponse(name: "Select Nationality")
    @Published var accountNo            : String              = ""
    @Published var relation             : String              = ""
    
    @Published var isSaveValidated                            = false
    @Published var isBankSaveValidated                        = false
    
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
    
    func addCashPickupOnAppear() {
        observeCashPickupValidationScopes()
    }
    
    func addBankBeneficiaryOnAppear() {
        observeBankValidationScopes()
    }
    
    //MARK: - NAVIGATION
    func navigateToBeneficiaryDetail() {
       self.destinationView  = AnyView(BeneficiaryDetailView())
       self.goToNext         = true
   }
    
    func navigateToEditBankBeneficiary() {
       self.destinationView  = AnyView(EditBeneficiaryBankView())
       self.goToNext         = true
   }
    
    func navigateToEditCashPickupBeneficiary() {
       self.destinationView  = AnyView(EditBeneficiaryCashPickupView())
       self.goToNext         = true
   }
    
    func navigateToSelectBeneficiarySheet() {
        self.destinationView = AnyView(SelectBeneficiaryTypeBottomSheet())
        self.goToNext        = true
    }
    
    func navigateToBenfAddedSuccessfull() {
        self.destinationView = AnyView(BeneficiaryAddSuccessfulView())
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
    
    @Published var successfullyAddedBeneficiary : Bool = false
    func addCashPickupBeneficiary() {
        repo.createCashPickupBeneficiaryAPICall(fullName: firstName, nationality: selectedNationality.id ?? "", phone: phone, address: address, gender: selectedGenderType.title, relationShip: relation)
        repo.$cashPickupBeneficiaryNormalCreationStatus.sink { status in
            if let isCreated = status{
                if isCreated{
                    //showSheet(view: AnyView(BeneficiaryAddSuccessfulView()), after: 0.3, isFullScreen: true, isTransferent: false)
                    self.successfullyAddedBeneficiary = true
                    HomeDataHandler.shared.collectionPoint = "AGENT"
                    self.relation = "TRUE"
                }
            }
        }.store(in: &subscribers)
    }
    
    func addCashPickupBeneficiaryBusiness() {
        let pdfContractDoc  = pdfData(from: URL(string: beneficiaryData.contractPath) ?? URL(fileURLWithPath: ""))
        repo.createCashPickupBusinessAPICall(fullName: firstName, nationality: selectedNationality.id ?? "", phoneNumber: phone, address: address, invoice: pdfContractDoc)
        repo.$cashPickupBeneficiaryBusinessCreationStatus.sink { status in
            if let isCreated = status{
                if isCreated{
                   // showSheet(view: AnyView(BeneficiaryAddSuccessfulView()), after: 0.3, isFullScreen: true, isTransferent: false)
                    HomeDataHandler.shared.collectionPoint = "AGENT"
                    self.relation = "TRUE"
                }
            }
        }.store(in: &subscribers)
    }
    
    func addBankBeneficiaryBusiness() {
        let pdfContractDoc  = pdfData(from: URL(string: beneficiaryData.contractPath) ?? URL(fileURLWithPath: ""))
        repo.createBankBeneficiaryBusinessAPICall(fullName: firstName, nationality: selectedNationality.id ?? "", phone: phone, address: address, bankId:  selectedBankName.id ?? "", accNo: "TR"+accountNo, invoice: pdfContractDoc)
        repo.$bankBeneficiaryBusinessCreationStatus.sink { status in
            if let isCreated = status{
                if isCreated{
                    //showSheet(view: AnyView(BeneficiaryAddSuccessfulView()), after: 0.3, isFullScreen: true, isTransferent: false)
                    HomeDataHandler.shared.collectionPoint = "BANK"
                    self.relation = "TRUE"
                }
            }
        }.store(in: &subscribers)
    }
    
    func addBankBeneficiary() {
        repo.createBankBeneficiaryAPICall(fullName: firstName, nationality: selectedNationality.id ?? "", phone: phone, address: address, gender: selectedGenderType.title, relationShip: relation, bankId: selectedBankName.id ?? "", accNo: "TR"+accountNo)
        repo.$bankBeneficiaryNormalCreationStatus.sink { status in
            if let isCreated = status{
                if isCreated{
                   // showSheet(view: AnyView(BeneficiaryAddSuccessfulView()), after: 0.3, isFullScreen: true, isTransferent: false)
                    HomeDataHandler.shared.collectionPoint = "BANK"
                    self.relation = "TRUE"
                }
            }
        }.store(in: &subscribers)
    }
    
    //MARK: - CUSTOME METHODS
    private func observeCashPickupValidationScopes() {
        Publishers.CombineLatest4($firstName, $selectedNationality, $phone, $address)
            .map { name, nationality, phone, address in
                return self.validate(firstName: self.firstName, nationality: self.selectedNationality.id ?? "", phone: phone, address: address)
            }
            .sink(receiveValue: { isValidate in
                self.isSaveValidated = isValidate
            })
            .store(in: &subscribers)
    }
    
    @Published var firstValidationCheck  = false
    @Published var secondValidationCheck = false
    
    private func observeBankValidationScopes() {

        Publishers.CombineLatest4($firstName, $selectedNationality, $phone, $address)
            .map { name, nationality, phone, address in
                return self.validate(firstName: self.firstName, nationality: self.selectedNationality.id ?? "", phone: phone, address: address)
            }
            .sink(receiveValue: { isValidate in
                self.firstValidationCheck = isValidate
            })
            .store(in: &subscribers)
        
        Publishers.CombineLatest($accountNo, $selectedBankName)
            .map { accountNo, bank in
                return self.validate(selectedBank: bank.id ?? "", accountNo: accountNo)
            }
            .sink(receiveValue: { isValidate in
                self.secondValidationCheck = isValidate
            })
            .store(in: &subscribers)
        
        Publishers.CombineLatest($firstValidationCheck, $secondValidationCheck)
            .map { first, second in
                return first && second
            }
            .sink(receiveValue: { isValidate in
                self.isBankSaveValidated = isValidate
            })
            .store(in: &subscribers)
    }
    
    func validate(firstName:String, nationality:String, phone:String, address:String) -> Bool {
        if firstName.isEmpty {
            return false
        }else if nationality.isEmpty {
            return false
        }else if phone.isEmpty{
            return false
        }else if address.isEmpty{
            return false
        }else{
            return true
        }

    }
    
    private func validate(selectedBank:String, accountNo:String) -> Bool {
        if selectedBank.isEmpty {
            return false
        }else if accountNo.isEmpty || accountNo.count != 24{
            return false
        }else{
            return true
        }

    }
    
//    func loadPDF() -> Data? {
//        guard let url = Bundle.main.url(forResource: "invoice", withExtension: "pdf") else {
//            print("PDF file not found in bundle.")
//            return nil
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            return data
//        } catch {
//            print("Error loading PDF data: \(error)")
//            return nil
//        }
//    }
    
    private func getMergedAllBeneficiaries()  {
        self.allBeneficiaries = []
        
        for item in bankBeneficiaries ?? []{
            allBeneficiaries?.append(CommonBeneficiaryModel(id: item.id, title: item.fullName, subTitle: "IBAN: \(item.accountNumber ?? "")", address: item.bankBeneficiaryBankDTO?.name,beneficiaryType: .bank_Transfer, accTypeIsBuiessness: item.typeOfBeneficiary  == "Business"))
        }
        
        for item in cashPickUpBeneficiaries ?? []{
            allBeneficiaries?.append(CommonBeneficiaryModel(id: item.id, title: item.fullName, subTitle: "Phone : \(item.phoneNumber ?? "")", address: item.address, beneficiaryType: .cash_Pickup, accTypeIsBuiessness: item.typeOfBeneficiary  == "Business"))
        }
        

    }

}
