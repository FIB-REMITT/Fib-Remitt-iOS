//
//  SelectBeneficiaryTypeBottomSheet.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import SwiftUI

struct SelectBeneficiaryTypeBottomSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navTracker: NavTracker
    @ObservedObject var vm = BeneficiaryViewModel()
    var body: some View {
        SheetHolder (onClickOutSide: {
            navTracker.navigationPath.removeLast()
        }){
            VStack(spacing: 10){
                TextBaseMedium(text: "Add Beneficiary", fg_color: .textMute).padding(.bottom, 10)
 
                FRSimpleDirectedButton(title: AvailableBeneficiaryType.bank_Transfer.title,  cornerRadius: 7) {
                   // vm.navigateToEditBankBeneficiary()
                    navTracker.navigationPath.append(BeneficiaryFlowScene.editBankBeneficiary)
                }
                FRSimpleDirectedButton(title: AvailableBeneficiaryType.cash_Pickup.title, cornerRadius: 7) {
                    //vm.navigateToEditCashPickupBeneficiary()
                    navTracker.navigationPath.append(BeneficiaryFlowScene.editCashPickupBeneficiary)
                }
  
            }
            
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
    }
}

#Preview {
    SelectBeneficiaryTypeBottomSheet()
}
