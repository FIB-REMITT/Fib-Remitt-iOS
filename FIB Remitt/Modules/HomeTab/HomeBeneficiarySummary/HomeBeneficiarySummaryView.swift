//
//  HomeBeneficiarySummaryView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomeBeneficiarySummaryView: View {
    @ObservedObject var vm = HomeViewModel()
    var beneficiaryResponse = HomeDataHandler.shared.beneficiaryCollectionResponse
    var body: some View {
        VStack(spacing:15){
            navigationBar
            contextContainer
            Spacer()
            bottomButton
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
    }
}

//MARK: - VIEW COMPONENTS
extension HomeBeneficiarySummaryView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Summary", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    
    private var contextContainer : some View{
        VStack{
            SimpleHInfoCellView(info: HomeDataHandler.shared.deliveryMethodType)
            SimpleHInfoCellView(title: "Purpose", info: beneficiaryResponse?.purposeTitle ?? "")
            FRVContainer (backgroundColor:.frForground){
                TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                VStack(spacing:10){
                    SimpleHColonInfoView(title : "Name", info: beneficiaryResponse?.receiver?.fullName ?? "")
                    SimpleHColonInfoView(title : "Bank Name", info: beneficiaryResponse?.receiver?.bankName ?? "N/A")
                    SimpleHColonInfoView(title : "IBAN", info: beneficiaryResponse?.receiver?.accountNumber ?? "N/A" )
                    SimpleHColonInfoView(title : "Type", info: beneficiaryResponse?.receiver?.typeOfBeneficiary ?? "")
                    SimpleHColonInfoView(title : "Relation", info: beneficiaryResponse?.receiver?.relationship ?? "")
                    SimpleHColonInfoView(title : "Phone", info: beneficiaryResponse?.receiver?.phoneNumber ?? "")
                    SimpleHColonInfoView(title : "Address", info: beneficiaryResponse?.receiver?.address ?? "")}
            }
            
            
            FRVContainer (backgroundColor:.frForground){
                TextBaseMedium(text: "Transfer Summary", fg_color: .text_Mute)
                VStack(spacing:10){
                    SimpleHInfoRegularView(title: "Amount to transfer", info: "\(beneficiaryResponse?.transaction?.amountToTransfer ?? 0)")
                    
                    SimpleHInfoRegularView(title: "Service charge", info: "+ \(beneficiaryResponse?.transaction?.charge ?? 0)")
                    Divider()
                    SimpleHModInfoView(title: "Total payable", info: "\(beneficiaryResponse?.transaction?.totalPayable ?? 0)",fontStyle: .titleBold)
                    SimpleHModInfoView(title: "Recipient gets", info: roundAmount(doubleValue: beneficiaryResponse?.transaction?.amountReceivable ?? 0,format: "%.4f"), textColor: Color.primary500, fontStyle: .allBold)
                }
            }
        }
    }
    private var bottomButton : some View{
        FRVerticalBtn(title: "Procced", btnColor: .primary500) {self.proccedBtnPressed()}
    }
}

//MARK: - ACTIONS
extension HomeBeneficiarySummaryView{
    private func notificationBtnPressed() {showToast(message: "No notification found!") }
    private func proccedBtnPressed() {
        vm.navigateToPayViaFIB()
    }
}

#Preview {
    HomeBeneficiarySummaryView()
}
