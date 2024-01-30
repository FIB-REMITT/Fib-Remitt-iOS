//
//  HomeRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct HomeRootView: View {
    @State var isSelected = false
    @State var isNotSelected = true
    
   
    @State var transferAmount = ""
        
    @ObservedObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack{
            Color.frBackground.ignoresSafeArea()
            VStack (spacing: 16){
                //Spacer()
                topBarContainer
                ScrollView{
                    VStack(spacing:16){
                        topProfileContainer
                        topAmountInputContainer
                        deliveryMethodContainer
                        purposeContainer
                        termsAndConditionContainer
                        bottomProccedButton
                    }
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext, destination: { vm.destinationView })
        .onTapGesture {hideKeyboard()}
        .onAppear(){vm.viewWillAppearCalled()
//            vm.apiReceivedInBank(beneficiaryId: "76284f97-e50d-402d-b52d-4710f5341c2b", fromCurrency: "IQD", amountToTransfer: "45000", toCurrency: "TRY", paymentMethod: "BANK", collectionPoint: "BANK", purposeId: "2217ff09-e479-4a60-b8f2-297c9912e481", invoice: loadPDF())
            
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
   

   
}

//MARK: - VIEW COMPONENTS
extension HomeRootView{
    private var topBarContainer : some View{
        HStack{
            Image("logo_horizantal")
            Spacer()
            FRTextDropDownButton(title: "Eng")
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
                FRVerticalField(placeholder: "Enter Amount", inputText: $transferAmount)
                    .frame(width: UI.scnWidth * 0.5)
                    .keyboardType(.numberPad)
                FRSimpleDropDownButton(title: "IQD", icon: "iraq_flag")
            }
            
            TextBaseMedium(text: "Recipient gets", fg_color: .text_Mute)
            HStack{
                FRVerticalField(placeholder: "Enter Amount", inputText: $transferAmount)
                    .frame(width: UI.scnWidth * 0.5)
                    .keyboardType(.numberPad)
                FRSimpleDropDownButton(title: "IQD", icon: "turkey")
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
            FRCheckbox(isSelected: $isSelected)
            FRTextButton(title: "Terms and Conditions", action: {self.termsAndConditionBtnPressed()})
            Spacer()
        }
    }
    
    private var bottomProccedButton : some View{
        FRVerticalBtn(title: "Procced", btnColor: .primary500) {self.proccedBtnPressed()}
    }
}

//MARK: - ACTIONS
extension HomeRootView{
    private func notificationBtnPressed() {}
    private func proccedBtnPressed() {vm.navigateSelectBeneficiary()}
    private func termsAndConditionBtnPressed() {}
    private func purposeButtonPressed(){
        showSheet(view: AnyView(PurposePicker(purposes: HomeDataHandler.shared.purposes, itemSelect: { selectedItem in
            self.vm.selectedPurpose = selectedItem
        })))
    }
}

#Preview {
    HomeRootView()
}
