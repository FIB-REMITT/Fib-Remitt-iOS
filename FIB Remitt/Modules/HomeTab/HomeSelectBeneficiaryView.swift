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
    var body: some View {
        VStack (spacing: 25){
            HStack{
                
            }
            HStack{
                TextBaseMedium(text: "Select Bank Account",fg_color: .textMute)
                Spacer()
                Button(action: {
                }, label: {
                    TextBaseMedium(text: "+Add New",fg_color: .primary500).underline()
                })}
            VStack{
                AccountInfoCellView(selected: $isSelected)
                AccountInfoCellView(selected: $isNotSelected)
                AccountInfoCellView(selected: $isNotSelected)
                AccountInfoCellView(selected: $isNotSelected)
            }

            Spacer()
            FRVerticalBtn(title: "Procced", btnColor: .primary500) {}
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
    }
}

#Preview {
    HomeSelectBeneficiaryView()
}
