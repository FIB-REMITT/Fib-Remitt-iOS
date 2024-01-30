//
//  EditBeneficiaryCashPickupView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct EditBeneficiaryCashPickupView: View {
    @ObservedObject var vm = BeneficiaryViewModel()
    
    @State var text : String = ""
    @State var isSelected : Bool = true
    @State var isNotSelected : Bool = true
    
    var body: some View {
        ZStack{
            Color.fr_background.ignoresSafeArea()
            VStack(spacing: 15){
                navigationBar
                FRVContainer (backgroundColor:.frForground){
                    VStack(alignment:.leading, spacing: 12){
                        TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                        FRVerticalField(placeholder: "Full Name", placeholderIcon: "user_ico", inputText: $text)
                        FRSimpleDropDownButton(title: "Nationality", icon: "nationality_ico")
                        FRVerticalField(placeholder: "Phone number", placeholderIcon: "call_ico", inputText: $text)
                        FRVerticalField(placeholder: "Address", placeholderIcon: "location_ico", inputText: $text)}
                    
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
                    FRVerticalField(placeholder: "Relation (Optional)", placeholderIcon: "nationality_ico", inputText: $text)
                }
                Spacer()
                bottomSaveButton
            }
            .padding()
            .navigationBarHidden(true)
           
        }

    }
}
//MARK: - VIEW COMPONENTS
extension EditBeneficiaryCashPickupView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Cash Pick-up Beneficiary")
    }
    private var bottomSaveButton : some View{
        FRVerticalBtn(title: "Save", btnColor: .primary500) {}
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
#Preview {
    EditBeneficiaryCashPickupView()
}
