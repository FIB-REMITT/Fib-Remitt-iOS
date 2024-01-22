//
//  HomeRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct HomeRootView: View {
    @State var isSelected = false
    @State var isNotSelected = true
    @State var transferAmount = ""
    var body: some View {
        ZStack{
            Color.frBackground.ignoresSafeArea()
            VStack (spacing: 16){
                Spacer()
                FRVContainer (spacing: 7, backgroundColor: .frForground){
                    TextBaseMedium(text: "Transfer amount", fg_color: .text_Mute)
                    HStack{
                        FRTextField(placeholder: Text("Enter Amount"), text: $transferAmount)
                        FRSimpleDropDownButton(title: "IQD", icon: "turkey")
                    }
                    
                    TextBaseMedium(text: "Recipient gets", fg_color: .text_Mute)
                    HStack{
                        FRTextField(placeholder: Text("Enter Amount"), text: $transferAmount)
                        FRSimpleDropDownButton(title: "IQD", icon: "turkey")
                    }
                    Divider().padding(.horizontal)
                    TextSmallRegular(text: "Conversion rate 1 TRY = 43.53 IQD", fg_color: .primary400)
                }
                FRVContainer (spacing: 7, backgroundColor: .frForground){
                    TextBaseMedium(text: "Delivery Method", fg_color: .text_Mute)
                    HStack{
                        FRCircularRadioButton(isSelected: $isSelected)
                        FRCircularRadioButton(isSelected: $isNotSelected, title: "Cash Pickup")
                    }
                }
                FRVContainer (backgroundColor: .frForground){
                    TextBaseMedium(text: "Purpose", fg_color: .text_Mute)
                    FRSimpleDropDownButton()
                }
                FRCheckbox(isSelected: $isSelected)
                FRVerticalBtn(title: "Procced", btnColor: .primary500) {}
                Spacer()
            }
            .padding()
            
        }.onTapGesture {hideKeyboard()}
    }
}

#Preview {
    HomeRootView()
}
