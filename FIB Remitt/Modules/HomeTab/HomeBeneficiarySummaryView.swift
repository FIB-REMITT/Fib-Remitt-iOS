//
//  HomeBeneficiarySummaryView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomeBeneficiarySummaryView: View {
    var body: some View {
        VStack(spacing:10){
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
                    SimpleHInfoView(title: "Amount to transfer", info: "125,000 IQD")
                    
                    SimpleHInfoView(title: "Service charge", info: "+ 5,000 IQD")
                    Divider()
                    SimpleHInfoView(title: "Total payble", info: "130,000 IQD")
                    SimpleHInfoView(title: "Recipient gets", info: "2,875 TRY")}.foregroundColor(Color.primary500)
            }
            Spacer()
            FRVerticalBtn(title: "Procced", btnColor: .primary500) {}
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
    }
}

#Preview {
    HomeBeneficiarySummaryView()
}
