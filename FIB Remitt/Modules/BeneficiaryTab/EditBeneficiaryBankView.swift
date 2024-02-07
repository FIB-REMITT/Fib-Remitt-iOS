//
//  EditBeneficiaryBankView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct EditBeneficiaryBankView: View {
    @ObservedObject var vm = BeneficiaryViewModel()
    @State var isPickerShown = false
    var fromHomeRoot : Bool = false
    var body: some View {
        let filePickerView = FilePickerView(
            isPickerShown: $isPickerShown,
            allowedContentTypes: [UTType.pdf],
            onSelect: { url in
                BenficiaryDataHandler.shared.contractPath = url.absoluteString
                print("Selected file: \(url.lastPathComponent.removingPercentEncoding ?? "")")
            },
            onError: { error in
                print("Error: \(error.localizedDescription)")
            }
        )
        
        ZStack{
            Color.fr_background.ignoresSafeArea()
            VStack(spacing: 15){
                navigationBar
                ScrollView{
                    FRVContainer (backgroundColor:.frForground){
                        VStack(alignment:.leading, spacing: 12){
                            TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                            HStack{
                                FRVerticalField(placeholder: "Full Name", placeholderIcon: "user_ico", inputText: $vm.firstName)
//                                FRVerticalField(placeholder: "Last Name", placeholderIcon: "user_ico", inputText: $vm.lastName)
                            }
                            
                            FRSimpleDropDownButton(title: vm.selectedNationality.name
                                                   ?? "Select Nationality", icon: "nationality_ico",action: {nationalityBtnPressed()})
                            FRVerticalField(placeholder: "Phone number", placeholderIcon: "call_ico", inputText: $vm.phone).keyboardType(.numberPad)
                            FRVerticalField(placeholder: "Address", placeholderIcon: "location_ico", inputText: $vm.address)}
                        
                        beneficiaryTypeSelectionRadioStack
                        ZStack{
                            if vm.selectedBeneficaryAccountType == .personal{
                                genderSelectionContainer
                            }else{
                                Button(action: {
                                    self.isPickerShown = true
                                }, label: {
                                    DocPickerView(title: BenficiaryDataHandler.shared.contractPath.extractFileName().isEmpty ? "Please upload contract document" : BenficiaryDataHandler.shared.contractPath.extractFileName())
                                        .fileImporter(
                                            isPresented: $isPickerShown,
                                            allowedContentTypes: filePickerView.allowedContentTypes,
                                            onCompletion: filePickerView.handleResult
                                        )
                                })
                            }
                        }
                        
                        bankDetailContainer
                    }
                }
                bottomSaveButton
            }
            .padding()
            .navigationBarHidden(true)
            .onChange(of: vm.firstName, perform: { value in
               let isValid = vm.validate(firstName: vm.firstName, nationality: vm.selectedNationality.id ?? "", phone: vm.phone, address: vm.address)
                vm.isBankSaveValidated = isValid
            })
            .onTapGesture {hideKeyboard()}
            .onAppear(){self.viewOnAppearCalled()}
        }
        
    }
}
//MARK: - VIEW COMPONENTS
extension EditBeneficiaryBankView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Bank Beneficiary")
    }
    private var genderSelectionContainer : some View{
        VStack(alignment:.leading){
            TextMediumMedium(text: "Gender", fg_color: .text_fade)
            HStack{
                ForEach(Gender.allCases, id: \.self) { item in
                    FRCircularRadioButton(isSelected: Binding(get: { vm.selectedGenderType == item },
                                                              set: { newValue in
                        if newValue {
                            vm.selectedGenderType = item
                            HomeDataHandler.shared.deliveryMethodType = item.title
                        }
                    }), title: item.title)
                }
            }
            
            FRVerticalField(placeholder: "Relation (Optional)", placeholderIcon: "nationality_ico", inputText: $vm.relation)
        }
    }
    private var beneficiaryTypeSelectionRadioStack : some View{
        VStack(alignment:.leading){
            TextMediumMedium(text: "Type of Beneficiary", fg_color: .text_fade)
            HStack{
                ForEach(BeneficiaryAccountType.allCases, id: \.self) { item in
                    FRCircularRadioButton(isSelected: Binding(get: { vm.selectedBeneficaryAccountType == item },
                                                              set: { newValue in
                        if newValue {
                            vm.selectedBeneficaryAccountType = item
                            HomeDataHandler.shared.deliveryMethodType = item.title
                        }
                    }), title: item.title)
                    
                }
            }
        }
    }
    
    private var bankDetailContainer : some View{
        VStack(alignment:.leading, spacing: 10){
            TextBaseMedium(text: "Bank Details", fg_color: .text_Mute)
            //  FRVerticalField(placeholder: "Bank Name", placeholderIcon: "bank_gry_ico", inputText: $vm.bankName)
            FRSimpleDropDownButton(title: vm.selectedBankName.name ?? "Select Bank", icon: "bank_gry_ico", action: {bankNameBtnPressed()})
            FRVerticalField(placeholder: "Please enter 24 digit IBAN", placeholderIcon: "acc_no", inputText: $vm.accountNo,maxCharacter: 24).keyboardType(.numberPad)
        }
    }
    
    private var bottomSaveButton : some View{
        FRVerticalControlBtn(isDisabled:$vm.isBankSaveValidated, title: "Save") {self.saveBtnPressed()}
    }
}

//MARK: - ACTIONS
extension EditBeneficiaryBankView{
    private func notificationBtnPressed() {}
    private func bankNameBtnPressed() {
        showSheet(view: AnyView(BankPicker(banks: BenficiaryDataHandler.shared.banks, itemSelect: { item in
            self.vm.selectedBankName = item
        })))
    }
    private func nationalityBtnPressed() {
        showSheet(view: AnyView(NationalityPicker(nations: BenficiaryDataHandler.shared.nationalities, itemSelect: { item in
            self.vm.selectedNationality = item
        })))
    }
    private func saveBtnPressed() {
        if vm.selectedBeneficaryAccountType == .personal{
            
            vm.addBankBeneficiary(fromHomeRoot: fromHomeRoot)
            
        }else if vm.selectedBeneficaryAccountType == .buissness{
            vm.addBankBeneficiaryBusiness()
        }
    }
    
    private func viewOnAppearCalled() {
        vm.addBankBeneficiaryOnAppear()
    }
}
#Preview {
    EditBeneficiaryBankView()
}
