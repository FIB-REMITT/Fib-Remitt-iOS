//
//  BeneficiaryRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct BeneficiaryRootView: View {
    @State var isNotSelected : Bool = false
    @State var isSelected    : Bool = true
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack{
                    BeneficiaryTypeCellView(selected: $isSelected, title: "All")
                    BeneficiaryTypeCellView(selected: $isNotSelected, title: "Bank Transfer", icon: "bank_ico")
                    BeneficiaryTypeCellView(selected: $isNotSelected, title: "Cash Pick-up")
                }}
            AccountInfoCellView(selected: $isNotSelected)
            AccountInfoCellView(selected: $isNotSelected)
            AccountInfoCellView(selected: $isNotSelected)
            AccountInfoCellView(selected: $isNotSelected)
            Spacer()
        }
        .padding()
        .background(Color.fr_background.ignoresSafeArea())
    }
}

#Preview {
    BeneficiaryRootView()
}
