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
        .onAppear(){self.viewWillAppearCall()}
        
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
//                Image("turkey")
//                    .imageDefaultStyle()
//                    .frame(width: 15)
            }
            TextBaseMedium(text:BenficiaryDataHandler.shared.beneficiaryType == .cash_Pickup ? vm.selectedCashPickUpBeneficiary?.fullName ?? "": vm.selectedBankBeneficiary?.fullName ?? "", fg_color: .textRegula)
            Spacer()
            
            //Button {self.trashBtnPressed()} label: { Image("trash_red_ico") }.padding(10)
          //  Button {self.editBtnPressed()} label: { Image("edit_ico") }
        }
    }
    
    private var contextMiddleInfoSection : some View{
        VStack (spacing:10){
            SimpleHColonInfoView(title: "Phone no.", info: BenficiaryDataHandler.shared.beneficiaryType == .cash_Pickup ? vm.selectedCashPickUpBeneficiary?.phoneNumber ?? "": vm.selectedBankBeneficiary?.phoneNumber ?? "")
            SimpleHColonInfoView(title: "Nationality", info: BenficiaryDataHandler.shared.beneficiaryType == .cash_Pickup ? vm.selectedCashPickUpBeneficiary?.nationality ?? "": vm.selectedBankBeneficiary?.nationality ?? "")
            SimpleHColonInfoView(title: "Address", info: BenficiaryDataHandler.shared.beneficiaryType == .cash_Pickup ? vm.selectedCashPickUpBeneficiary?.address ?? "": vm.selectedBankBeneficiary?.address ?? "")
            SimpleHColonInfoView(title: "Gender", info: BenficiaryDataHandler.shared.beneficiaryType == .cash_Pickup ? vm.selectedCashPickUpBeneficiary?.gender ?? "": vm.selectedBankBeneficiary?.gender ?? "")
            SimpleHColonInfoView(title: "Type of Beneficiary", info: BenficiaryDataHandler.shared.beneficiaryType == .cash_Pickup ? vm.selectedCashPickUpBeneficiary?.typeOfBeneficiary ?? "": vm.selectedBankBeneficiary?.typeOfBeneficiary ?? "")
        }
    }
    
    private var bankDetail : some View{
        VStack(alignment: .leading, spacing: 12){
            if BenficiaryDataHandler.shared.beneficiaryType == .bank_Transfer{
                TextBaseMedium(text: "Bank Details", fg_color: .textRegula)
                VStack (spacing:10){
                    SimpleHColonInfoView(title: "Bank Name", info: vm.selectedBankBeneficiary?.bankBeneficiaryBankDTO?.name ?? "")
                    SimpleHColonInfoView(title: "IBAN", info: vm.selectedBankBeneficiary?.accountNumber ?? "")
                }
            }
        }
    }
}

//MARK: - ACTIONS
extension BeneficiaryDetailView{
//    private func trashBtnPressed() {
//
//    }
    private func editBtnPressed() {
        vm.navigateToEditBankBeneficiary()
    }
    private func viewWillAppearCall(){
        vm.detailViewOnAppear(beneficiaryType: BenficiaryDataHandler.shared.beneficiaryType)
    }
}
#Preview {
    BeneficiaryDetailView()
}
