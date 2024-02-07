//
//  SelectBeneficiaryTypeBottomSheet.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import SwiftUI

struct SelectBeneficiaryTypeBottomSheet: View {
    var fromHomeRoot: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = BeneficiaryViewModel()
    var body: some View {
        SheetHolder (onClickOutSide: {
            presentationMode.wrappedValue.dismiss()
        }){
            VStack(spacing: 10){
                TextBaseMedium(text: "Add Beneficiary", fg_color: .textMute).padding(.bottom, 10)
 
                FRSimpleDirectedButton(title: AvailableBeneficiaryType.bank_Transfer.title,  cornerRadius: 7) {
                    vm.navigateToEditBankBeneficiary(fromHomeRoot: fromHomeRoot)
                }
                FRSimpleDirectedButton(title: AvailableBeneficiaryType.cash_Pickup.title, cornerRadius: 7) {
                    vm.navigateToEditCashPickupBeneficiary(fromHomeRoot: fromHomeRoot)
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
