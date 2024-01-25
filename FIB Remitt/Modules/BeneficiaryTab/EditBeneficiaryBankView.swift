//
//  EditBeneficiaryBankView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct EditBeneficiaryBankView: View {
    @State var text : String = ""
    @State var isSelected : Bool = true
    @State var isNotSelected : Bool = true
    var body: some View {
        VStack(spacing: 15){
            navigationBar
            FRVContainer (backgroundColor:.frForground){
                VStack(alignment:.leading, spacing: 12){
                    TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                    FRVerticalField(placeholder: "Full Name", inputText: $text)
                    FRSimpleDropDownButton(title: "Nationality", icon: "nationality_ico")
                    FRVerticalField(placeholder: "Phone number", inputText: $text)
                    FRVerticalField(placeholder: "Address", inputText: $text)}
                VStack(alignment:.leading){
                    TextMediumMedium(text: "Type of Beneficiary", fg_color: .text_fade)
                    HStack{
                        FRCircularRadioButton(isSelected: $isSelected, title: "Personal")
                        FRCircularRadioButton(isSelected: $isNotSelected, title: "Business")
                    }
                }
                
                VStack(alignment:.leading){
                    TextMediumMedium(text: "Gender", fg_color: .text_fade)
                    HStack{
                        FRCircularRadioButton(isSelected: $isSelected, title: "Male")
                        FRCircularRadioButton(isSelected: $isNotSelected, title: "Female")
                    }
                }
                
                VStack(alignment:.leading, spacing: 10){
                    TextBaseMedium(text: "Bank Details", fg_color: .text_Mute)
                    FRVerticalField(placeholder: "Bank Name", inputText: $text)
                    FRVerticalField(placeholder: "Account Number", inputText: $text)
                }
            }
            bottomSaveButton
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color.fr_background.ignoresSafeArea())

    }
}
//MARK: - VIEW COMPONENTS
extension EditBeneficiaryBankView{
//    private var bottomButton : some View{}
    private var navigationBar : some View {
        FRNavigationBarView(title: "Bank Beneficiary")
    }
    private var bottomSaveButton : some View{
        FRVerticalBtn(title: "Save", btnColor: .primary500) {}
    }
}

//MARK: - ACTIONS
extension EditBeneficiaryBankView{
    private func notificationBtnPressed() {

    }
}
#Preview {
    EditBeneficiaryBankView()
}
