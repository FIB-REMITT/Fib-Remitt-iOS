//
//  EditBeneficiaryBankView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct EditBeneficiaryBankView: View {
    @ObservedObject var vm = BeneficiaryViewModel()
    

    var body: some View {
        ZStack{
            Color.fr_background.ignoresSafeArea()
            VStack(spacing: 15){
                navigationBar
                ScrollView{
                    FRVContainer (backgroundColor:.frForground){
                        VStack(alignment:.leading, spacing: 12){
                            TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                            HStack{
                                FRVerticalField(placeholder: "First Name", placeholderIcon: "user_ico", inputText: $vm.firstName)
                                FRVerticalField(placeholder: "Last Name", placeholderIcon: "user_ico", inputText: $vm.lastName)
                            }
                            
                            FRSimpleDropDownButton(title: "Nationality", icon: "nationality_ico",action: {nationalityBtnPressed()})
                            FRVerticalField(placeholder: "Phone number", placeholderIcon: "call_ico", inputText: $vm.phone)
                            FRVerticalField(placeholder: "Address", placeholderIcon: "location_ico", inputText: $vm.address)}
                        
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
                        
                        typeOfBeneficiarySubView
                        FRVerticalField(placeholder: "Relation (Optional)", placeholderIcon: "nationality_ico", inputText: $vm.relation)
                        
                        VStack(alignment:.leading, spacing: 10){
                            TextBaseMedium(text: "Bank Details", fg_color: .text_Mute)
                          //  FRVerticalField(placeholder: "Bank Name", placeholderIcon: "bank_gry_ico", inputText: $vm.bankName)
                            FRSimpleDropDownButton(title: "Bank Name", icon: "bank_gry_ico", action: {bankNameBtnPressed()})
                            FRVerticalField(placeholder: "Account Number", placeholderIcon: "acc_no", inputText: $vm.accountNo)
                        }
                    }
                }
                bottomSaveButton
            }
            .padding()
            .navigationBarHidden(true)
           
        }

    }
}
//MARK: - VIEW COMPONENTS
extension EditBeneficiaryBankView{
//    private var bottomButton : some View{}
    private var navigationBar : some View {
        FRNavigationBarView(title: "Bank Beneficiary")
    }
    private var bottomSaveButton : some View{
        FRVerticalBtn(title: "Save", btnColor: .primary500) {self.saveBtnPressed()}
    }
    
    private var typeOfBeneficiarySubView : some View{
        ZStack{
            if vm.selectedBeneficaryAccountType == .personal{
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
                }
            }else{
                Button(action: {
                    
                }, label: {
                    DocPickerView()
                })
            }
        }
    }
}

//MARK: - ACTIONS
extension EditBeneficiaryBankView{
    private func notificationBtnPressed() {}
    private func bankNameBtnPressed() {}
    private func nationalityBtnPressed() {}
    private func saveBtnPressed() {

    }
}
#Preview {
    EditBeneficiaryBankView()
}
