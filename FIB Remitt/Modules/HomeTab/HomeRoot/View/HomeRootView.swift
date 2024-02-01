//
//  HomeRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct HomeRootView: View {
    @State var isNotSelected = true
    @ObservedObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack{
            Color.frBackground.ignoresSafeArea()
            VStack (spacing: 16){
                topBarContainer
                ScrollView{
                    VStack(spacing:16){
                   //     topProfileContainer
                        topAmountInputContainer
                        deliveryMethodContainer
                        purposeContainer
                        termsAndConditionContainer
                        bottomProccedButton
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext, destination: { vm.destinationView })
        .onTapGesture {hideKeyboard()}
        .onAppear(){vm.viewWillAppearCalled()
        }
    }
   
}

//MARK: - VIEW COMPONENTS
extension HomeRootView{
    private var topBarContainer : some View{
        HStack{
            Image("logo_horizantal")
            Spacer()
            FRTextDropDownButton(title: vm.selectedLanguage.title, action: {languageButtonPressed()})
            FRBarButton(icon: "bell_ico")
        }
    }
    private var topProfileContainer : some View{
        FRHContainer(backgroundColor: Color.primary500){
            HStack{
                Image("profile_img")
                    .imageDefaultStyle()
                    .frame(width: 40)
                TextBaseMedium(text: "Oscar Pruitt", fg_color: .fr_forground)
                    .padding(.trailing,70)
                
            }
            .padding(6)
            .background(Color.primary400)
            .cornerRadius(100)
            Spacer()
            FRImageButton(image: "nav",size: 40)
        }
    }
    private var topAmountInputContainer : some View{
        FRVContainer (spacing: 7, backgroundColor: .frForground){
            TextBaseMedium(text: "Transfer amount", fg_color: .text_Mute)
            HStack{
                FRVerticalField(placeholder: "Enter Amount", inputText: $vm.transferAmount)
                    .frame(width: UI.scnWidth * 0.5)
                    .keyboardType(.numberPad)
                FRSimpleDropDownButton(title: "IQD", icon: "iraq_flag", action: {self.selectTransferCurrencyPressed()})
            }
            
            TextBaseMedium(text: "Recipient gets", fg_color: .text_Mute)
            HStack{
                FRVerticalField(placeholder: "Enter Amount", inputText: $vm.recipentAmount)
                    .frame(width: UI.scnWidth * 0.5)
                    .keyboardType(.numberPad)
                    .disabled(true)
                FRSimpleDropDownButton(title: vm.selectedRecipientCurrency.code ?? "", icon: vm.selectedRecipientCurrency.code == "TRY" ? "turkey" : "", action: {selectRecipientCurrencyPressed()})
            }
            Divider().padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 2)
            HStack {
                Spacer()
                TextSmallRegular(text: "Conversion rate 1 TRY = 43.53 IQD", fg_color: .primary400)
                Spacer()
            }
        }
    }
    
    private var deliveryMethodContainer : some View{
        FRVContainer (spacing: 7, backgroundColor: .frForground){
            TextBaseMedium(text: "Delivery Method", fg_color: .text_Mute)
            HStack{
                ForEach(DeliveryMethodEnum.allCases, id: \.self) { item in
                    FRCircularRadioButton(isSelected: Binding(get: { vm.selectedDeliveryMethod == item.title },
                                                              set: { newValue in
                        if newValue {
                            vm.selectedDeliveryMethod = item.title
                            HomeDataHandler.shared.deliveryMethodType = item.title
                        }
                    }),
                                          title: item.title)
                    
                }
            }
        }
    }
    
    private var purposeContainer : some View{
        FRVContainer (backgroundColor: .frForground){
            TextBaseMedium(text: "Purpose", fg_color: .text_Mute)
            Button(action: {
                purposeButtonPressed()
            }, label: {
                FRVContainer (backgroundColor: .fr_background){
                    HStack{
                        TextBaseRegular(text:vm.selectedPurpose.name ?? "Family Support", fg_color: .text_Mute)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.text_Mute)
                    
                }
                .cornerRadius(100)
            })
//            FRSimpleDropDownButton {
//                purposeButtonPressed()
//            }
        }
    }
    
    private var termsAndConditionContainer : some View{
        HStack(){
            FRCheckbox(isSelected: $vm.isTermsSelected)
            FRTextButton(title: "Terms and Conditions", action: {self.termsAndConditionBtnPressed()})
            Spacer()
        }
    }
    
    private var bottomProccedButton : some View{
        FRVerticalControlBtn(isDisabled: $vm.isProceedValidated, title: "Procced") {self.proccedBtnPressed()}
    }
}

//MARK: - ACTIONS
extension HomeRootView{
    private func notificationBtnPressed() {}
    private func proccedBtnPressed() {
        vm.storeHomeData()
        vm.navigateSelectBeneficiary()
    }
    private func termsAndConditionBtnPressed() {}
    private func purposeButtonPressed(){
        showSheet(view: AnyView(PurposePicker(purposes: HomeDataHandler.shared.purposes, itemSelect: { selectedItem in
            self.vm.selectedPurpose = selectedItem
        })))
    }
    private func selectRecipientCurrencyPressed(){
        showSheet(view: AnyView(CurrencyPicker(currencies: HomeDataHandler.shared.currencies, itemSelect: { selectedItem in
            self.vm.selectedRecipientCurrency = selectedItem
            self.vm.convertCurrency()
        })))
    }
    
    private func selectTransferCurrencyPressed(){
        showSheet(view: AnyView(CurrencyPicker(currencies: HomeDataHandler.shared.transferCurrencies, itemSelect: { selectedItem in
            self.vm.selectedRecipientCurrency = selectedItem
            self.vm.convertCurrency()
        })))
    }
    
    private func languageButtonPressed(){
        showSheet(view: AnyView(FRSimpleStaticPicker(type: Language.self, selected: $vm.selectedLanguage)))
    }
}

#Preview {
    HomeRootView()
}
