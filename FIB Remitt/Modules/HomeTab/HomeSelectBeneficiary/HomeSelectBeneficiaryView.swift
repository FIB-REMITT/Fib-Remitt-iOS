//
//  HomeSelectBeneficiaryView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomeSelectBeneficiaryView: View {
    @State var isSelected : Bool = true
    @State var isNotSelected : Bool = false
    @ObservedObject var vm = HomeViewModel()
    var body: some View {
        VStack (spacing: 25){
            navigationBar
            topAccountCreation
            contexContainer
            Spacer()
            bottomButton
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
    }
}

//MARK: - View Components
extension HomeSelectBeneficiaryView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Select Beneficiary", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    private var topAccountCreation : some View{
        HStack{
            TextBaseMedium(text: "Select Bank Account",fg_color: .textMute)
            Spacer()
            Button(action: { self.createAccountBtnPressed()}, label: {
                TextBaseMedium(text: "+Add New",fg_color: .primary500).underline()
            })}
    }
    private var contexContainer : some View{
        VStack{
            AccountInfoCellView(selected: $isSelected)
            AccountInfoCellView(selected: $isNotSelected)
            AccountInfoCellView(selected: $isNotSelected)
            AccountInfoCellView(selected: $isNotSelected)
        }
    }
    private var bottomButton : some View{
        FRVerticalBtn(title: "Procced", btnColor: .primary500) {self.proccedBtnPressed()}
    }
}

//MARK: - ACTIONS
extension HomeSelectBeneficiaryView{
    private func createAccountBtnPressed() {
        
    }
    private func notificationBtnPressed() {
        
    }
    private func proccedBtnPressed() {
        vm.navigateToBeneficiarySummary()
    }
}

#Preview {
    HomeSelectBeneficiaryView()
}
