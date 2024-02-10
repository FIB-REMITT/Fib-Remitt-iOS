//
//  HomeRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct HomeRootView: View {
    @ObservedObject var vm = HomeViewModel()
    @EnvironmentObject var navTracker:NavTracker
    
    @FocusState var recepientIsFofused
    @FocusState var transferIsFocused
    
    var body: some View {
        ZStack{
            Color.frBackground.ignoresSafeArea()
            VStack (spacing: 16){
                topBarContainer
                ScrollView{
                    VStack(spacing:16){
                        topAmountInputContainer
                        deliveryMethodContainer
                        purposeContainer
                        termsAndConditionContainer
                    }
                }
                bottomProccedButton.padding(.bottom)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationBarHidden(true)
//        .navigationDestination(isPresented: $vm.goToNext, destination: { vm.destinationView })
        .navigationDestination(for: HomeFlowScene.self, destination: { scene in
            scene.view
        })
        .navigationDestination(for: BeneficiaryFlowScene.self, destination: { scene in scene.view
        })
        .onTapGesture {hideKeyboard()}
        .onChange(of: vm.transferAmount, perform: {newValue in recipientAmountUpdate(); vm.validateProceedButton()})
        .onChange(of: vm.recipentAmount, perform: {newValue in transferAmountUpdate(); vm.validateProceedButton()})
        .onChange(of: vm.isTermsSelected, perform: {newValue in vm.validateProceedButton()})
        .onAppear(){vm.viewWillAppearCalled()}
    }
   
}

//MARK: - VIEW COMPONENTS
extension HomeRootView{
    private var topBarContainer : some View{
        HStack{
            Image("logo_horizantal")
            Spacer()
            FRTextDropDownButton(title: vm.selectedLanguage.title, action: {languageButtonPressed()})
            FRBarButton(icon: "bell_ico", action: {notificationBtnPressed()})
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
                FRVerticalField(placeholder: "Enter Amount", inputText: $vm.transferAmount, maxCharacter: 20)
                    .focused($transferIsFocused)
                    .frame(width: UI.scnWidth * 0.5)
                    .keyboardType(.numberPad)
                FRSimpleDropDownButton(title: "IQD", icon: "iraq_flag", action: {self.selectTransferCurrencyPressed()})
            }
            
            TextBaseMedium(text: "Recipient gets", fg_color: .text_Mute)
            HStack{
                FRVerticalField(placeholder: "Enter Amount", inputText: $vm.recipentAmount, maxCharacter: 20)
                    .focused($recepientIsFofused)
                    .frame(width: UI.scnWidth * 0.5)
                    .keyboardType(.numberPad)
                
                FRSimpleDropDownButton(title: vm.selectedRecipientCurrency.code ?? "", icon: vm.selectedRecipientCurrency.code == "TRY" ? "turkey" : "", action: {selectRecipientCurrencyPressed()})
            }
            Divider().padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 2)
            HStack {
                Spacer()
                if let conversionRates       = HomeDataHandler.shared.conversionRates{
                    let targetRate           = conversionRates.toDictionary()[vm.selectedRecipientCurrency.code ?? "TRY"]
                    TextSmallRegular(text: "Conversion rate 1 IQD = \(roundAmount(doubleValue: targetRate ?? 0.02341, format: "%.4f")) TRY", fg_color: .primary400)
                }
                
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
                    }), title: item.title)
                    
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
                        TextBaseRegular(text:vm.selectedPurpose.name ?? "Select Purpose", fg_color: .text_Mute)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.text_Mute)
                    
                }
                .cornerRadius(100)
            })
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
    private func notificationBtnPressed() {showToast(message: "No notification found!")}
    private func proccedBtnPressed() {
        vm.storeHomeData()
        navTracker.navigationPath.append(HomeFlowScene.beneficiarySelection)
    }
    private func termsAndConditionBtnPressed() {}
    private func purposeButtonPressed(){
        showSheet(view: AnyView(PurposePicker(purposes: HomeDataHandler.shared.purposes, itemSelect: { selectedItem in
            self.vm.selectedPurpose = selectedItem
            self.vm.validateProceedButton()
        })))
    }
    private func selectRecipientCurrencyPressed(){
        showSheet(view: AnyView(CurrencyPicker(currencies: HomeDataHandler.shared.currencies, itemSelect: { selectedItem in
            self.vm.selectedRecipientCurrency = selectedItem
        })))
    }
    
    private func selectTransferCurrencyPressed(){
        showSheet(view: AnyView(CurrencyPicker(currencies: HomeDataHandler.shared.transferCurrencies, itemSelect: { selectedItem in
            self.vm.selectedRecipientCurrency = selectedItem
            self.vm.convertCurrencyForTransfer()
        })))
    }
    
    private func languageButtonPressed(){
        showSheet(view: AnyView(FRSimpleStaticPicker(type: Language.self, selected: $vm.selectedLanguage)))
    }
    
    private func recipientAmountUpdate() {
        if !recepientIsFofused{
            vm.convertCurrencyForTransfer()
        }
    }
    
    private func transferAmountUpdate() {
        if !transferIsFocused{
            vm.convertCurrencyForRecipient()
        }
    }
    
//    private func recepientAmountUpdate() {
//        if !recepientIsFofused{
//            vm.convertCurrencyForRecipient()
//        }
//    }
}

#Preview {
    HomeRootView()
}
