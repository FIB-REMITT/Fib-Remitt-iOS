//
//  HomeBeneficiarySummaryView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomeBeneficiarySummaryView: View {
    @ObservedObject var vm = HomeViewModel()
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
            SimpleHInfoCellView()
            SimpleHInfoCellView(title: "Purpose", info: "Family Support")
            FRVContainer (backgroundColor:.frForground){
                TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                VStack(spacing:10){
                    SimpleHColonInfoView(title: "Name", info: "Mehmet Öztürk")
                    SimpleHColonInfoView(title: "Bank Name", info: "Ziraat Bank")
                    SimpleHColonInfoView(title: "Account No.", info: "124 458 458 856")
                    SimpleHColonInfoView(title: "Type", info: "Individual")
                    SimpleHColonInfoView(title: "Relation", info: "Uncle")
                    SimpleHColonInfoView(title: "Phone", info: "+90 212 555 1212")
                    SimpleHColonInfoView(title: "Address", info: "Ankara, Turkey")}
            }
            
            FRVContainer (backgroundColor:.frForground){
                TextBaseMedium(text: "Transfer Summary", fg_color: .text_Mute)
                VStack(spacing:10){
                    SimpleHInfoRegularView(title: "Amount to transfer", info: "125,000 IQD")
                    
                    SimpleHInfoRegularView(title: "Service charge", info: "+ 5,000 IQD")
                    Divider()
                    SimpleHModInfoView(title: "Total payble", info: "130,000 IQD",fontStyle: .titleBold)
                    SimpleHModInfoView(title: "Recipient gets", info: "2,875 TRY", textColor: Color.primary500, fontStyle: .allBold)
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
    private func notificationBtnPressed() {
        
    }
    private func proccedBtnPressed() {
        vm.navigateToPayViaFIB()
    }
}

#Preview {
    HomeBeneficiarySummaryView()
}
