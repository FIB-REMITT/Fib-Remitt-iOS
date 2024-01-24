//
//  BeneficiaryDetailView.swift
//  FIB Remitt
//
//  Created by Izak on 23/1/24.
//

import SwiftUI

struct BeneficiaryDetailView: View {
    @ObservedObject var vm = BeneficiaryViewModel()
    var body: some View {
        VStack(spacing:20){
            navigationBar
            contextContainer
            Spacer()
        }
        .padding()
        .background(Color.fr_background.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
        
    }
}
//MARK: - VIEW COMPONENTS
extension BeneficiaryDetailView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Beneficiary")
    }
    private var contextContainer : some View{
        FRVContainer (backgroundColor:.frForground){
            contextTopInfoSection
            contextMiddleInfoSection
            bankDetail
        }
    }
    
    private var contextTopInfoSection : some View{
        HStack{
            ZStack (alignment: .bottomTrailing){
                Image("bank_ico")
                    .padding(14)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(Color.frBorder, lineWidth: 1)
                    }
                Image("turkey")
                    .imageDefaultStyle()
                    .frame(width: 15)
            }
            TextBaseMedium(text:"John Doe", fg_color: .textRegula)
            Spacer()
            
            Button {self.trashBtnPressed()} label: { Image("trash_red_ico") }.padding(10)
            Button {self.editBtnPressed()} label: { Image("edit_ico") }
        }
    }
    
    private var contextMiddleInfoSection : some View{
        VStack (spacing:10){
            SimpleHColonInfoView(title: "Phone number", info: "+96455989898")
            SimpleHColonInfoView(title: "Nationality", info: "Ankara.Turkey")
            SimpleHColonInfoView(title: "Phone number", info: "+96455989898")
            SimpleHColonInfoView(title: "Gender", info: "Male")
            SimpleHColonInfoView(title: "Type of Beneficiary", info: "Personal")
        }
    }
    
    private var bankDetail : some View{
        VStack(alignment: .leading, spacing: 12){
            TextBaseMedium(text: "Bank Details", fg_color: .textRegula)
            VStack (spacing:10){
                SimpleHColonInfoView(title: "Bank Name", info: "Ziraat Bank")
                SimpleHColonInfoView(title: "Account Number", info: "124 458 458 856")
            }
        }
    }
}

//MARK: - ACTIONS
extension BeneficiaryDetailView{
    private func trashBtnPressed() {

    }
    private func editBtnPressed() {
        vm.navigateToEditBankBeneficiary()
    }
}
#Preview {
    BeneficiaryDetailView()
}
