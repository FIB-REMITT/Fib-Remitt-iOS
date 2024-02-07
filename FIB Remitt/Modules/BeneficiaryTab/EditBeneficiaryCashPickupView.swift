//
//  EditBeneficiaryCashPickupView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct EditBeneficiaryCashPickupView: View {
    @ObservedObject var vm          = BeneficiaryViewModel()
    @State var isPickerShown        = false
    
    @State var text : String        = ""
    @State var isSelected : Bool    = true
    @State var isNotSelected : Bool = true
    
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
                            FRSimpleDropDownButton(title: vm.selectedNationality.name ?? "Select Nationality", icon: "nationality_ico", action: {self.nationalityButtonPressed()})
                            FRVerticalField(placeholder: "Phone number", placeholderIcon: "call_ico", inputText: $vm.phone).keyboardType(.numberPad)
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
                            FRVerticalField(placeholder: "Relation (Optional)", placeholderIcon: "nationality_ico", inputText: $vm.relation)
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
                }
                Spacer()
                bottomSaveButton
            }
            .padding()
            .navigationBarHidden(true)
            .onChange(of: vm.firstName, perform: { value in
               let isValid = vm.validate(firstName: vm.firstName, nationality: vm.selectedNationality.id ?? "", phone: vm.phone, address: vm.address)
                vm.isSaveValidated = isValid
            })
            .onTapGesture {hideKeyboard()}
            .onAppear(){viewOnAppearCalled()}
        }

    }
}
//MARK: - VIEW COMPONENTS
extension EditBeneficiaryCashPickupView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Cash Pick-up Beneficiary")
    }
    private var bottomSaveButton : some View{
        FRVerticalControlBtn(isDisabled: $vm.isSaveValidated, title: "Save") {self.saveButtonPressed()}
    }
}
extension EditBeneficiaryCashPickupView{
    private func nationalityButtonPressed() {
        hideKeyboard()
        showSheet(view: AnyView(NationalityPicker(nations: BenficiaryDataHandler.shared.nationalities, itemSelect: { item in
            self.vm.selectedNationality = item
        })))
    }
    
    private func saveButtonPressed(){
        if vm.selectedBeneficaryAccountType == .personal{
            vm.addCashPickupBeneficiary()
        }else if vm.selectedBeneficaryAccountType == .buissness{
            vm.addCashPickupBeneficiaryBusiness()
        }
    }
}

extension EditBeneficiaryCashPickupView{
    func viewOnAppearCalled() {
        vm.addCashPickupOnAppear()
    }
}

#Preview {
    EditBeneficiaryCashPickupView()
}
